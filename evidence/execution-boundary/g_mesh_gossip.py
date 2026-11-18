import asyncio
import random
import json
import logging
from typing import List, Dict
from koru_routing import KoruRoutingTable

logger = logging.getLogger("GMeshGossip")


class GMeshGossipProtocol:
    def __init__(self, node_id: str, address: str, routing_table: KoruRoutingTable, gossip_interval: float = 1.5):
        self.node_id = node_id
        self.address = address
        self.routing_table = routing_table
        self.gossip_interval = gossip_interval
        self.is_running = False

    async def start(self):
        self.is_running = True
        logger.info(f"[*] Gossip protocol started for node {self.node_id} at {self.address}")
        while self.is_running:
            try:
                await self._execute_gossip_round()
            except Exception as e:
                logger.error(f"Error during gossip round on {self.node_id}: {e}")
            await asyncio.sleep(self.gossip_interval)

    def stop(self):
        self.is_running = False
        logger.info(f"[-] Gossip protocol stopped for node {self.node_id}")

    async def _execute_gossip_round(self):
        if not self.routing_table.peers:
            return

        peer_ids = list(self.routing_table.peers.keys())
        target_peer_id = random.choice(peer_ids)
        target_address = self.routing_table.peers[target_peer_id]["address"]

        local_state_payload = {
            "node_id": self.node_id,
            "address": self.address,
            "entropy": self.routing_table.fixed_point_entropy,
            "known_peers": list(self.routing_table.peers.keys()),
        }

        await self._send_gossip_packet(target_address, local_state_payload)

    async def _send_gossip_packet(self, address: str, payload: dict):
        await asyncio.sleep(0.02)
        logger.debug(f"[{self.node_id}] Dispatched gossip state to {address}")

    def handle_incoming_gossip(self, incoming_payload: dict):
        remote_id = incoming_payload.get("node_id")
        remote_addr = incoming_payload.get("address")
        remote_entropy = incoming_payload.get("entropy", 0.0)

        if remote_id and remote_id != self.node_id:
            self.routing_table.update_peer(remote_id, remote_addr, remote_entropy)
