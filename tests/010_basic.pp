# Test setting config
sshd::config {
  "HostKey": value => ["/etc/hostkey1","/etc/hostkey2"];
  "Protocol": value => "3";
  "Subsystem": value => "sftp foo";
}
