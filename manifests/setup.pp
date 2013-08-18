# This class will ensure SSH is setup, configured and running.
class sshd::setup {
  service {"sshd":
    enable => true,
    ensure => running,
    hasrestart => true,
    hasstatus => true,
    require => Package["openssh-server"]
  }	
  
  package {"openssh-server":
    ensure => installed
  }
}
