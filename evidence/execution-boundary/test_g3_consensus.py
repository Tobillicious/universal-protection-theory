import asyncio

import pytest

from g3_healer import G3ConsensusHealer
from g_mesh_telemetry import GMeshTelemetryEncryptor


@pytest.fixture
def encryptor():
    return GMeshTelemetryEncryptor()


@pytest.fixture
def mock_peer_client():
    from unittest.mock import AsyncMock

    client = AsyncMock()
    client.fetch_signed_checkpoint = AsyncMock(
        return_value={"state_root": "0xdeadbeef12345678", "signature": "sig_valid_gmesh_root"}
    )
    return client


@pytest.fixture
def healer():
    return G3ConsensusHealer(node_id="G3-Test-Alpha", divergence_threshold=1e-4)


def test_telemetry_encryption_roundtrip(encryptor):
    node_id = "G3-Beta-Node"
    epoch = 42
    state_hash = "0x1234567890abcdef"
    metrics = {"cpu_load": 0.12, "entropy": 0.0005}

    encrypted_packet = encryptor.pack_payload(node_id, epoch, state_hash, metrics)
    assert len(encrypted_packet) > 12

    decrypted = encryptor.unpack_payload(encrypted_packet)
    assert decrypted["node_id"] == node_id
    assert decrypted["epoch"] == epoch
    assert decrypted["state_hash"] == state_hash
    assert decrypted["metrics"] == metrics


def test_evaluate_state_drift_within_threshold(healer):
    local_state = {"entropy_metric": 0.50000}
    quorum_state = {"entropy_metric": 0.50005}
    has_drifted = asyncio.run(healer.evaluate_state_drift(local_state, quorum_state))
    assert not has_drifted


def test_evaluate_state_drift_exceeds_threshold(healer):
    local_state = {"entropy_metric": 0.50000}
    quorum_state = {"entropy_metric": 0.50200}
    has_drifted = asyncio.run(healer.evaluate_state_drift(local_state, quorum_state))
    assert has_drifted


def test_execute_roll_forward_success(healer, mock_peer_client):
    target_epoch = 105
    success = asyncio.run(healer.execute_roll_forward(mock_peer_client, target_epoch))
    assert success is True
    mock_peer_client.fetch_signed_checkpoint.assert_awaited_once_with(target_epoch)


def test_execute_roll_forward_invalid_checkpoint(healer, mock_peer_client):
    mock_peer_client.fetch_signed_checkpoint.return_value = {
        "state_root": "0xbad",
        "signature": "",
    }
    target_epoch = 106
    success = asyncio.run(healer.execute_roll_forward(mock_peer_client, target_epoch))
    assert success is False
