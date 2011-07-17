# This class will ensure SSH is setup, configured and running.
class sshd::setup {
  service {"sshd":
    enable => true,
    ensure => running,
    hasrestart => true,
    hasstatus => true,
    require => Package["openssh"]
  }	
  
  package {"openssh":
    name   => $operatingsystem ? {
      Debian  => 'openssh-server',
      default => 'openssh',
    }
    ensure => installed,
  }
}
