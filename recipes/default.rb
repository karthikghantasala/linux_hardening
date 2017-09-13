#
# Cookbook:: linux_hardening
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

raise ArgumentError,"ERROR: Unsupported Operating system #{node['platform'] }. Please run this cookbook on RHEL systems only!!!" if node['platform_family'] != 'rhel'

#65
service "crond" do
  action [:enable, :start]
end

#66-71
node['linux_hardening']['cron_dirs'].each do |cron_dir|
  directory "/etc/#{cron_dir}" do
    owner 'root'
	group 'root'
	mode '0644'
  end
  end
 
 node['linux_hardening']['cron_files'].each do |cron_file|
  file "/etc/#{cron_file}" do
    owner 'root'
	group 'root'
	mode '0644'
  end
  end
 
#configure cron last point unclear

#sys file permissions firt point unclear

#75-82
node['linux_hardening']['etc_files1'].each do |etc_file1|
  directory "/etc/#{etc_file1}" do
    owner 'root'
	group 'root'
	mode '0644'
  end
  end

node['linux_hardening']['etc_files2'].each do |etc_file2|
  directory "/etc/#{etc_file2}" do
    owner 'root'
	group 'root'
	mode '0000'
  end
  end

#node['linux_hardening']['xined_services'].each do |xinetd_service|
##  execute "#{xinetd_service}" do
#  command 'sed -e \"6s/yes/no/\"'
#end
#end  

node['linux_hardening']['xinetd_services'].each do |xinetd_service|
bash "#{xinetd_service}" do
  cwd '/etc/xinetd.d'
  code <<-EOH
    sed -e '6s/yes/no/' "#{xinetd_service}" 
    EOH
  only_if { ::File.exist?("/etc/xinetd.d/#{xinetd_service}") } 
#   only_if { 'if -f [#{xinetd_service}]', :cwd => '/etc/xinetd.d/' }
  end   
end

bash "legacy_check" do
#  cwd '/etc/xinetd.d'
  code <<-EOH
   grep '^+:' "/etc/passwd" 
    if [ "$?" -eq "0" ] ; then
	  sudo userdel '+'
        
	fi
	EOH
end 


#ruby_block "legacy_check" do
#    block do
#        Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)      
#        live_stream true
#		command1 = " if [ grep '^+:' /etc/passwd"
#        commandout1 = shell_out(command1)
#        if commandout1 != nil 
#          command2 = "sudo userdel '+'"
#           command2 = "sudo rm -f /etc/test.txt"
#        end
 #       node.normal['my_attribute'] = commandout.stdout
#        :action, 'resource[name]', :timer
##	end
 #   action :run
#end



#user 'user with uid zero' do
#  comment 'A user with 0 uid'
#  uid '0'
#  action: delete
#  not_if { ::Process.uid.zero? }
#   not_if ()
#end 


#execute 'Ensure root is the only UID 0 account' do
##  command "id root |cut -d'(' -f1 |cut -d'=' -f2"
#  live_stream true
#end

#ruby_block "something" do
#    block do
#        #tricky way to load this Chef::Mixin::ShellOut utilities
#        Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)      
#        command = "id root |cut -d'(' -f1 | cut -d'=' -f1"
#        cmd.live_stdout = $stdout
#        cmd.run_command
#        command = "id -u root"
#        commandout = shell_out(command)
#		commandout = commandout.to_i
#		command_out = Integer(command_out)
#       node.normal['my_attribute'] = command_out.stdout
#		node.normal['my_attribute'] = commandout
#    end
#    action :create
#end

#log "Welcome to Chef, #{node['my_attribute']}!" do
#  level :info
#end

#http://stackoverflow.com/questions/1274605/ruby-search-file-text-for-a-pattern-and-replace-it-with-a-given-value 
#file_names = ['foo.txt', 'bar.txt']
#file_names.each do |file_name|
#  text = File.read(file_name)
#  new_contents = text.gsub(/search_regexp/, "replacement string")
  # To merely print the contents of the file, use:
#  puts new_contents
  # To write changes to the file, use:
#  File.open(file_name, "w") {|file| file.puts new_contents }
#end


#LG=$(grep '^+:' /etc/passwd) #if they're in passwd, they're a user
#if [$? -eq 0]; then 
#    #We've found a user
#    echo "We've found the user '+'!"
#    sudo userdel '+'
#    echo "Deleted."
#else
#    echo "Couldn't find the user '+'."
#fi