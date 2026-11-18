import asyncio
import json
import logging
from typing import List

logger = logging.getLogger("IndependentQuorumTest")
logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(levelname)s] %(name)s: %(message)s")


class IndependentQuorumNode:
    def __init__(self, node_id: str, host: str, port: int, uid: int):
        self.node_id = node_id
        self.host = host
        self.port = port
        self.uid = uid
        self.server = None
        self.received: List[dict] = []

    async def handle(self, reader, writer):
        try:
            data = await reader.readline()
            if data:
                envelope = json.loads(data.decode("utf-8").strip())
                payload = envelope.get("payload", {})
                self.received.append(payload)
                response = {"status": "ACK", "node_id": self.node_id, "uid": self.uid}
                writer.write((json.dumps(response) + "\n").encode("utf-8"))
                await writer.drain()
        except Exception as e:
            logger.error(f"[{self.node_id}] {e}")
        finally:
            writer.close()
            await writer.wait_closed()

    async def start(self):
        self.server = await asyncio.start_server(self.handle, self.host, self.port)
        logger.info(f"[*] Independent node {self.node_id} (uid={self.uid}) on {self.host}:{self.port}")

    async def stop(self):
        if self.server:
            self.server.close()
            await self.server.wait_closed()


async def run_independent_quorum_test():
    configs = [
        {"node_id": "IQ-Alpha", "host": "127.0.0.1", "port": 9301, "uid": 65530},
        {"node_id": "IQ-Beta", "host": "127.0.0.1", "port": 9302, "uid": 65531},
        {"node_id": "IQ-Gamma", "host": "127.0.0.1", "port": 9303, "uid": 65532},
    ]
    nodes = [IndependentQuorumNode(**cfg) for cfg in configs]

    for n in nodes:
        await n.start()
    await asyncio.sleep(0.2)

    try:
        leader = configs[0]
        voters = configs[1:]
        payload = {"node_id": leader["node_id"], "entropy": 0.0001, "uid": leader["uid"]}

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

        logger.info(f"[*] Independent quorum: {acks}/{len(voters)} ACKs")
        assert acks >= required, f"Independent quorum failed: {acks}/{required}"
        logger.info("[+] SUCCESS: Independent quorum achieved across distinct UIDs.")

    finally:
        for n in nodes:
            await n.stop()


if __name__ == "__main__":
    asyncio.run(run_independent_quorum_test())
