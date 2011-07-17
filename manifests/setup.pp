# This class will ensure SSH is setup, configured and running.
class sshd::setup {
  service { "sshd":
    enable => true,
    ensure => running,
    hasrestart => true,
    hasstatus => true,
    require => Package["openssh"],
    name => $operatingsystem ? {
      Debian  => 'ssh',
      default => 'sshd',
    }
  }	
  
  package { "openssh":
    name   => $operatingsystem ? {
      Debian  => 'openssh-server',
      default => 'openssh',
    },
    ensure => installed,
  }
}
