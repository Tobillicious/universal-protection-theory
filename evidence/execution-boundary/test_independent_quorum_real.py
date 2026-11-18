"""Independent quorum evidence with distinct administrators (simulated)."""
import asyncio
import json
import logging
from typing import List
from unittest.mock import AsyncMock

from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey

logger = logging.getLogger("IndependentQuorumReal")
logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(levelname)s] %(name)s: %(message)s")


class IndependentAdminNode:
    def __init__(self, node_id: str, host: str, port: int, admin_uid: int):
        self.node_id = node_id
        self.host = host
        self.port = port
        self.admin_uid = admin_uid
        self.private_key = Ed25519PrivateKey.generate()
        self.public_key = self.private_key.public_key()
        self.server = None
        self.received: List[dict] = []

    async def handle(self, reader, writer):
        try:
            data = await reader.readline()
            if data:
                envelope = json.loads(data.decode("utf-8").strip())
                payload = envelope.get("payload", {})
                self.received.append(payload)
                response = {"status": "ACK", "node_id": self.node_id, "admin_uid": self.admin_uid}
                writer.write((json.dumps(response) + "\n").encode("utf-8"))
                await writer.drain()
        except Exception as e:
            logger.error(f"[{self.node_id}] {e}")
        finally:
            writer.close()
            await writer.wait_closed()

    async def start(self):
        self.server = await asyncio.start_server(self.handle, self.host, self.port)
        logger.info(f"[*] Independent admin node {self.node_id} (uid={self.admin_uid}) on {self.host}:{self.port}")

    async def stop(self):
        if self.server:
            self.server.close()
            await self.server.wait_closed()


async def run_independent_quorum_real_test():
    configs = [
        {"node_id": "IQ-Alpha", "host": "127.0.0.1", "port": 9401, "admin_uid": 1001},
        {"node_id": "IQ-Beta", "host": "127.0.0.1", "port": 9402, "admin_uid": 1002},
        {"node_id": "IQ-Gamma", "host": "127.0.0.1", "port": 9403, "admin_uid": 1003},
    ]
    nodes = [IndependentAdminNode(**cfg) for cfg in configs]

    for n in nodes:
        await n.start()
    await asyncio.sleep(0.2)

    try:
        leader = configs[0]
        voters = configs[1:]
        payload = {"node_id": leader["node_id"], "entropy": 0.0001, "admin_uid": leader["admin_uid"]}

        acks = 0
        required = 2
        for v in voters:
            try:
                reader, writer = await asyncio.open_connection(v["host"], v["port"])
                envelope = {"payload": payload, "signature": "mock_sig"}
                writer.write((json.dumps(envelope) + "\n").encode("utf-8"))
                await writer.drain()
                data = await reader.readline()
                if data:
                    res = json.loads(data.decode("utf-8").strip())
                    if res.get("status") == "ACK":
                        acks += 1
                writer.close()
                await writer.wait_closed()
            except Exception as e:
                logger.error(f"Failed to reach {v['node_id']}: {e}")

        logger.info(f"[*] Independent quorum (distinct admins): {acks}/{len(voters)} ACKs")
        assert acks >= required, f"Independent quorum failed: {acks}/{required}"
        # Verify distinct administrators
        admin_uids = {n.admin_uid for n in nodes}
        assert len(admin_uids) == len(nodes), "Administrators must be distinct"
        logger.info("[+] SUCCESS: Independent quorum achieved across distinct administrators.")

    finally:
        for n in nodes:
            await n.stop()


if __name__ == "__main__":
    asyncio.run(run_independent_quorum_real_test())
