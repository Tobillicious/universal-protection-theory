import asyncio
import json
import hmac
import hashlib
import logging

logger = logging.getLogger("GMeshClient")
logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(levelname)s] %(name)s: %(message)s")

from koru_gmesh_research_key import load_research_key


class GMeshClient:
    def __init__(self, node_id: str, host: str, port: int, secret_key: bytes = None):
        self.node_id = node_id
        self.host = host
        self.port = port
        self.secret_key = load_research_key() if secret_key is None else load_research_key(secret_key.hex() if type(secret_key) is bytes else "")

    def _sign_payload(self, payload: dict) -> str:
        payload_bytes = json.dumps(payload, sort_keys=True).encode("utf-8")
        return hmac.new(self.secret_key, payload_bytes, hashlib.sha256).hexdigest()

    async def send_state_packet(self, target_entropy: float, known_peers: list):
        payload = {
            "node_id": self.node_id,
            "address": f"{self.host}:{self.port}",
            "entropy": target_entropy,
            "known_peers": known_peers,
        }

        signature = self._sign_payload(payload)
        envelope = {"payload": payload, "signature": signature}

        try:
            logger.info(f"[*] Connecting to G-Mesh server at {self.host}:{self.port}...")
            reader, writer = await asyncio.open_connection(self.host, self.port)

            message = json.dumps(envelope) + "\n"
            writer.write(message.encode("utf-8"))
            await writer.drain()

            logger.info(f"[{self.node_id}] Signed state packet dispatched. Awaiting quorum response...")

            data = await reader.readline()
            if data:
                response = json.loads(data.decode("utf-8").strip())
                logger.info(f"[{self.node_id}] Received server acknowledgment: {response}")
            else:
                logger.warning(f"[{self.node_id}] Server closed connection without response.")

            writer.close()
            await writer.wait_closed()

        except ConnectionRefusedError:
            logger.error(f"[-] Connection refused. Ensure the G-Mesh server is running on {self.host}:{self.port}.")
        except Exception as e:
            logger.error(f"[-] Error during client transmission: {e}")


async def main():
    client = GMeshClient(
        node_id="G3-Beta-Client",
        host="127.0.0.1",
        port=9001,
    )

    await client.send_state_packet(
        target_entropy=0.00025,
        known_peers=["G3-Alpha-Node", "G3-Gamma-Node"],
    )


if __name__ == "__main__":
    asyncio.run(main())
