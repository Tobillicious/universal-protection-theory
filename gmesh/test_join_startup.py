"""Safe startup assertions: no other hosts contacted or listeners opened in tests."""
import importlib.util
import sys
import unittest
from pathlib import Path
from unittest import mock


HERE = Path(__file__).with_name("join.py")
SPEC = importlib.util.spec_from_file_location("gmesh_relay_join", HERE)
join = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(join)


class StopAfterStartup(Exception):
    pass


class RelayTests(unittest.TestCase):
    def test_untrusted_peer_data_rendered_as_text(self):
        page = join.build_page(
            {"total_theorems": 0, "total_sorry": 0, "module_count": 0,
             "key_results": [], "key_results_found": 0},
            {"<img src=x onerror=alert(1)>": {"ip": "<script>", "port": "80"}})
        self.assertNotIn("<img src=x onerror", page)
        self.assertNotIn("<script>", page)
        self.assertIn("&lt;script&gt;", page)

    def test_default_startup_single_loopback_bind_and_no_discovery(self):
        evidence = {"total_theorems": 0, "total_sorry": 0,
                    "key_results_found": 0, "key_results": [], "module_count": 0}
        server = mock.Mock()
        server.server_address = ("127.0.0.1", 12345)
        with mock.patch.object(sys, "argv", ["join.py"]), \
             mock.patch.object(join, "fetch_evidence", return_value=evidence), \
             mock.patch.object(join.socketserver, "TCPServer", return_value=server) as tcp, \
             mock.patch.object(join.MeshDiscovery, "start") as discover, \
             mock.patch.object(join.subprocess, "Popen") as bonjour, \
             mock.patch.object(join.threading.Thread, "start"), \
             mock.patch.object(join.signal, "signal"), \
             mock.patch.object(join.time, "sleep", side_effect=StopAfterStartup):
            with self.assertRaises(StopAfterStartup):
                join.main()
        self.assertEqual(tcp.call_count, 1)
        self.assertEqual(tcp.call_args.args[0], ("127.0.0.1", 0))
        discover.assert_not_called()
        bonjour.assert_not_called()


if __name__ == "__main__":
    unittest.main()
