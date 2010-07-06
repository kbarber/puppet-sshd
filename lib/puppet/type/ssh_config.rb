Puppet::Type.newtype(:sshd_config) do
  @doc = "Manage the contents of /etc/sshd/sshd_config"

  ensurable

  newparam(:name) do
    desc "Configuration key to set"
    isnamevar
  end

  newproperty(:value, :array_matching => :all) do
    desc "Value to set key to"
  end
end
