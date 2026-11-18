import math
from typing import Dict, Optional, Tuple


class KoruRoutingTable:
    def __init__(self, node_id: str, fixed_point_entropy: float = 0.0):
        self.node_id = node_id
        self.fixed_point_entropy = fixed_point_entropy
        self.peers: Dict[str, Dict[str, any]] = {}

    def update_peer(self, peer_id: str, address: str, peer_entropy: float):
        topo_distance = abs(peer_entropy - self.fixed_point_entropy)
        self.peers[peer_id] = {
            "address": address,
            "entropy": peer_entropy,
            "topological_distance": topo_distance,
        }

    def remove_peer(self, peer_id: str):
        if peer_id in self.peers:
            del self.peers[peer_id]

    def get_optimal_next_hop(self, target_entropy: float) -> Optional[Tuple[str, str]]:
        if not self.peers:
            return None
        best_peer_id = min(
            self.peers.keys(),
            key=lambda pid: abs(self.peers[pid]["entropy"] - target_entropy),
        )
        return best_peer_id, self.peers[best_peer_id]["address"]
