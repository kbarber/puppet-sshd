require 'puppet/provider/parsedfile'

Puppet::Type.type(:sshd_config).provide(
  :parsed,
  :parent => Puppet::Provider::ParsedFile,
  :default_target => '/etc/ssh/sshd_config',
  #:default_target => '/tmp/sshd_config',
  :filetype => :flat
) do
  desc "The sshd_config provider that uses the ParsedFile class"

  commands :sshd => 'sshd'

  text_line :comment, :match => /^\s*#/
  text_line :blank, :match => /^\s*$/

  record_line :parsed, :fields => %w{name value}, :match => %r{^(\S+)\s+(.+)\s*$}

  def self.to_line(hash)
    return super unless hash[:record_type] == :parsed
    #p hash
    if(hash[:value].is_a?(Array))
    	str_array = []
    	hash[:value].each do |value|
    		str = "%s\t%s" % [hash[:name], value]
    		self.verify_sshd_line(str)
    		str_array << str
    	end
    	str = str_array.join("\n")
    else
    	str = "%s\t%s" % [hash[:name], hash[:value]]
    end
    
    str
  end
  
  def self.prefetch_hook(records)
   
    t = {}
     
    records.each do |i|
      if i.is_a?(Hash)
      	if(t[i[:name]])
      		cur_value = t[i[:name]][:value]
      		if cur_value.is_a?(Array)
      			t[i[:name]][:value] << i[:value] 
      		else
      			t[i[:name]][:value] = [cur_value, i[:value]]
      		end
      	else
      		i[:value] = [ i[:value] ]
	        t[i[:name]] = i
	    end
      end
    end
    result = []
    t.each do |key, value|
    	result << value
    end

    result
  end

  def self.verify_sshd_line(line)
    # path is currently hardcoded, needs to be fixed
    base = '/tmp/sshd_config' 
    # find a tmp file that does not exist
    # this should be built into Ruby?
    path = "#{base}.puppettmp_#{rand(10000)}"
    while File.exists?(path) or File.symlink?(path)
      path = "#{base}.puppettmp_#{rand(10000)}"
    end
    File.open(path, "w") { |f| f.print "#{line}\n" }
    begin
      sshd("-tf", path)
    rescue => detail
      raise Puppet::Error, "sshd failed for line: #{line}, #{detail}"
    ensure 
      File.unlink(path) if FileTest.exists?(path)
    end
  end


end
