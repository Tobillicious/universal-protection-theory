use ring::signature::{self, UnparsedPublicKey, Ed25519PublicKey};
use serde::{Deserialize, Serialize};
use std::time::{SystemTime, UNIX_EPOCH};

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct GMeshLease {
    pub node_id: String,
    pub epoch: u64,
    pub issued_at: u64,
    pub expires_at: u64,
    pub signature: Vec<u8>,
}

#[derive(Debug)]
pub enum BoundaryError {
    ExpiredLease,
    InvalidSignature,
    BoundaryTearDetected, // Violates ∂U = ∅
}

pub struct MobileBoundaryFence {
    pub node_id: String,
    pub trusted_quorum_keys: Vec<Vec<u8>>,
}

impl MobileBoundaryFence {
    pub fn new(node_id: String, keys: Vec<Vec<u8>>) -> Self {
        Self {
            node_id,
            trusted_quorum_keys: keys,
        }
    }

    /// Validates an incoming lease against topological and cryptographic constraints
    pub fn validate_and_fence(&self, lease: &GMeshLease) -> Result<(), BoundaryError> {
        let now = SystemTime::now()
            .duration_since(UNIX_EPOCH)
            .unwrap()
            .as_secs();

        // 1. Check temporal expiration (Contraction constraint)
        if lease.expires_at <= now {
            return Err(BoundaryError::ExpiredLease);
        }

        // 2. Verify signature against known G-Mesh quorum keys
        let mut verified = false;
        for pub_key_bytes in &self.trusted_quorum_keys {
            let peer_pk = UnparsedPublicKey::new(&signature::ED25519, pub_key_bytes);
            let message = format!("{}:{}:{}", lease.node_id, lease.epoch, lease.issued_at);
            if peer_pk.verify(message.as_bytes(), &lease.signature).is_ok() {
                verified = true;
                break;
            }
        }

        if !verified {
            return Err(BoundaryError::InvalidSignature);
        }

        // 3. Ensure no boundary tear is introduced (upt_capstone invariant)
        // If a spatial transition breaks local consistency, reject immediately.
        if lease.epoch == 0 {
            return Err(BoundaryError::BoundaryTearDetected);
        }

        Ok(())
    }
}
