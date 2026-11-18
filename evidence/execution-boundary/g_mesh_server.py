import asyncio
import json
import logging
import hmac
import hashlib
from typing import Dict, Any
from koru_routing import KoruRoutingTable
from g_mesh_gossip import GMeshGossipProtocol

logger = logging.getLogger("GMeshServer")
logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(levelname)s] %(name)s: %(message)s")

from koru_gmesh_research_key import load_research_key


class GMeshServer:
    def __init__(self, node_id: str, host: str, port: int, fixed_point_entropy: float = 0.0):
        self.node_id = node_id
        self.host = host
        self.port = port
        self.routing_table = KoruRoutingTable(node_id=node_id, fixed_point_entropy=fixed_point_entropy)
        self.gossip_protocol = GMeshGossipProtocol(
            node_id=node_id,
            address=f"{host}:{port}",
            routing_table=self.routing_table,
        )
        self.server: asyncio.Server = None
        self.research_key = load_research_key()

    def _verify_signature(self, payload: dict, signature: str) -> bool:
        payload_bytes = json.dumps(payload, sort_keys=True).encode("utf-8")
        expected = hmac.new(self.research_key, payload_bytes, hashlib.sha256).hexdigest()
        return hmac.compare_digest(expected, signature)

    async def handle_client_connection(self, reader: asyncio.StreamReader, writer: asyncio.StreamWriter):
        peer_addr = writer.get_extra_info("peername")
        logger.debug(f"[{self.node_id}] Incoming connection established from {peer_addr}")

        try:
            while True:
                data = await reader.readline()
                if not data:
                    break

                message_str = data.decode("utf-8").strip()
                if not message_str:
                    continue

                envelope = json.loads(message_str)
                payload = envelope.get("payload", {})
                signature = envelope.get("signature", "")

                if not self._verify_signature(payload, signature):
                    logger.warning(f"[{self.node_id}] Invalid signature from {peer_addr}")
                    response = {"status": "REJECTED", "node_id": self.node_id, "reason": "bad_signature"}
                    writer.write((json.dumps(response) + "\n").encode("utf-8"))
                    await writer.drain()
                    continue

                self.gossip_protocol.handle_incoming_gossip(payload)

                response = {"status": "ACK", "node_id": self.node_id}
                writer.write((json.dumps(response) + "\n").encode("utf-8"))
                await writer.drain()

        except asyncio.IncompleteReadError:
            logger.debug(f"[{self.node_id}] Connection closed abruptly by peer {peer_addr}")
        except json.JSONDecodeError:
            logger.error(f"[{self.node_id}] Malformed JSON received from {peer_addr}")
        except Exception as e:
            logger.error(f"[{self.node_id}] Error handling connection from {peer_addr}: {e}")
        finally:
            writer.close()
            await writer.wait_closed()

    async def start(self):
        self.server = await asyncio.start_server(
            self.handle_client_connection,
            self.host,
            self.port,
        )
        addr = self.server.sockets[0].getsockname()
        logger.info(f"[*] G-Mesh Server ({self.node_id}) listening actively on {addr[0]}:{addr[1]}")

        gossip_task = asyncio.create_task(self.gossip_protocol.start())

        async with self.server:
            await self.server.serve_forever()

    def stop(self):
        self.gossip_protocol.stop()
        if self.server:
            self.server.close()
        logger.info(f"[-] G-Mesh Server ({self.node_id}) shut down successfully.")


async def main():
    node_server = GMeshServer(
        node_id="G3-Alpha-Node",
        host="127.0.0.1",
        port=9001,
        fixed_point_entropy=0.0001,
    )
    try:
        await node_server.start()
    except KeyboardInterrupt:
        node_server.stop()


if __name__ == "__main__":
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        pass
