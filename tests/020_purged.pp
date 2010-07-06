resources {"sshd_config":
  purge => true
}
sshd::config{"PrintMotd":
  value => "no"
}
