# Set an sshd_config option. See man page for details.
#
# == Examples
#
# <b>1)</b> Set a few example options:
#
#   sshd::config{
#     "Protocol": value => "2",
#     "PrintMotd": value => "yes",
#   }
#
# == Synopsis
#
#   sshd::config {"<option>":
#     value => "<value>"
#   }
#
# == Parameters
#
# [<b>sshd::config{"<option>"</b>]
#   Configuration option
#
# [<b>value => "<value>"</b>]
#   Value
#
define sshd::config($value) {
  include sshd::setup
  
  sshd_config{$name:
    value => $value,
    notify => Service[sshd] 
  }
}
