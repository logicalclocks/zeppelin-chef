#
# Cookbook Name:: zeppelin
# Recipe:: install
#
# Copyright 2015, Jim Dowling
#
# All rights reserved
#

package_url = "#{node[:zeppelin][:url]}"
base_package_filename = File.basename(package_url)
cached_package_filename = "#{Chef::Config[:file_cache_path]}/#{base_package_filename}"

remote_file cached_package_filename do
  source package_url
  owner "#{node[:zeppelin][:user]}"
  mode "0644"
  action :create_if_missing
end

# Extract Zeppelin
bash 'extract-zeppelin' do
        user node[:zeppelin][:user]
        group node[:zeppelin][:group]
        code <<-EOH
                tar -xf #{cached_package_filename} -C #{node[:zeppelin][:dir]}
                touch #{node[:zeppelin][:dir]}/.zeppelin_extracted_#{node[:zeppelin][:version]}
        EOH
     not_if { ::File.exists?( "#{node[:zeppelin][:dir]}/.zeppelin_extracted_#{node[:zeppelin][:version]}" ) }
end


link node[:zeppelin][:base_dir] do
  owner node[:zeppelin][:user]
  group node[:zeppelin][:group]
  to node[:zeppelin][:home]
end


my_ip = my_private_ip()
spark_master_ip = private_recipe_ip("spark","master")
flink_jobmgr_ip = private_recipe_ip("flink","jobmanager")

template "#{node[:zeppelin][:home]}/conf/zeppelin-env.sh" do
  source "zeppelin-env.sh.erb"
  owner node[:zeppelin][:user]
  group node[:zeppelin][:group]
  mode 0655
  variables({ 
        :private_ip => my_ip,
        :spark_master => spark_master_ip
           })
end

file "#{node[:zeppelin][:home]}/conf/interpreter.json" do
 action :delete
end

template "#{node[:zeppelin][:home]}/conf/interpreter.json" do
  source "interpreter.json.erb"
  owner node[:zeppelin][:user]
  group node[:zeppelin][:group]
  mode 0655
  variables({ 
        :spark_master_ip => spark_master_ip,
        :flink_jobmgr_ip => flink_jobmgr_ip
           })
end
