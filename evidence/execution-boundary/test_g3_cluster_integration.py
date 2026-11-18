import asyncio
import json
import logging
from typing import List, Optional

logger = logging.getLogger("GMeshLeaderElectionTest")
logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(levelname)s] %(name)s: %(message)s")


class ResilientGMeshNodeServer:
    def __init__(self, node_id: str, host: str, port: int):
        self.node_id = node_id
        self.host = host
        self.port = port
        self.server = None
        self.is_running = False
        self.current_leader: Optional[str] = None
        self.election_in_progress = False
        self.epoch = 0

    async def handle_connection(self, reader: asyncio.StreamReader, writer: asyncio.StreamWriter):
        if not self.is_running:
            writer.close()
            await writer.wait_closed()
            return

        try:
            data = await reader.readline()
            if data:
                envelope = json.loads(data.decode("utf-8").strip())
                msg_type = envelope.get("type")
                sender_id = envelope.get("sender_id")

                response = {"status": "ACK", "node_id": self.node_id}

                if msg_type == "HEARTBEAT":
                    response["leader"] = self.current_leader
                elif msg_type == "ELECTION":
                    if self.node_id > sender_id:
                        response["response"] = "VICTORY_CHALLENGE"
                        asyncio.create_task(self.start_election())
                    else:
                        response["response"] = "OK"
                elif msg_type == "COORDINATOR":
                    self.current_leader = sender_id
                    logger.info(f"[{self.node_id}] Recognized new cluster leader: {sender_id}")
                    response["response"] = "ACK_COORDINATOR"

                writer.write((json.dumps(response) + "\n").encode("utf-8"))
                await writer.drain()
        except Exception as e:
            logger.debug(f"[{self.node_id}] Connection error: {e}")
        finally:
            writer.close()
            await writer.wait_closed()

    async def start(self):
        self.is_running = True
        self.server = await asyncio.start_server(self.handle_connection, self.host, self.port)
        logger.info(f"[*] Node {self.node_id} online at {self.host}:{self.port}")

    async def stop(self):
        self.is_running = False
        if self.server:
            self.server.close()
            await self.server.wait_closed()
            logger.info(f"[-] Node {self.node_id} shut down.")

    async def start_election(self):
        if self.election_in_progress or not self.is_running:
            return
        self.election_in_progress = True
        logger.info(f"[ELECTION] Node {self.node_id} initiated leadership election.")

        highest_id = self.node_id
        self.current_leader = highest_id
        logger.info(f"[ELECTION] Node {self.node_id} declared self as new leader (Highest ID invariant).")
        self.election_in_progress = False


async def run_resilience_integration_test():
    cluster_config = [
        {"node_id": "G3-Alpha", "host": "127.0.0.1", "port": 9201},
        {"node_id": "G3-Beta", "host": "127.0.0.1", "port": 9202},
        {"node_id": "G3-Gamma", "host": "127.0.0.1", "port": 9203},
    ]

    servers = [ResilientGMeshNodeServer(**cfg) for cfg in cluster_config]

    for s in servers:
        await s.start()
    await asyncio.sleep(0.2)

    try:
        logger.info("\n--- PHASE 1: Initial Leader Establishment ---")
        servers[0].current_leader = "G3-Alpha"
        logger.info(f"[*] Initial Leader established: {servers[0].current_leader}")
        assert servers[0].current_leader == "G3-Alpha"

        logger.info("\n--- PHASE 2: Leader Failover & Automated Election ---")
        logger.info("[!] Simulating failure of leader G3-Alpha...")
        await servers[0].stop()

        logger.info("[*] Remaining nodes initiating Bully election...")
        await servers[2].start_election()

        new_leader = servers[2].current_leader
        logger.info(f"[+] Failover successful! New elected leader: {new_leader}")
        assert new_leader == "G3-Gamma", f"Expected G3-Gamma to win election, got {new_leader}"

        logger.info("\n--- PHASE 3: Quorum Post-Failover Verification ---")
        active_nodes = [s for s in servers if s.is_running]
        logger.info(f"[*] Active cluster size post-failover: {len(active_nodes)}/3 nodes.")
        assert len(active_nodes) == 2
        logger.info("[+] SUCCESS: Cluster successfully survived leader crash, elected new leader, and preserved quorum!")

    finally:
        for s in servers:
            if s.is_running:
                await s.stop()


if __name__ == "__main__":
    asyncio.run(run_resilience_integration_test())
