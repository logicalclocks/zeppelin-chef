#
# Cookbook Name:: zeppelin
# Recipe:: install
#
# Copyright 2015, Jim Dowling
#
# All rights reserved
#

include_recipe "hops::wrap"

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
        user "root"
        group node[:zeppelin][:group]
        code <<-EOH
                set -e
                tar -xf #{cached_package_filename} -C #{Chef::Config[:file_cache_path]}
#                mv #{Chef::Config[:file_cache_path]}/zeppelin-#{node[:zeppelin][:version]}/* #{node[:zeppelin][:dir]}/
                mv #{Chef::Config[:file_cache_path]}/zeppelin-#{node[:zeppelin][:version]} #{node[:zeppelin][:dir]}
                mkdir -p #{node[:zeppelin][:home]}/run
                wget http://snurran.sics.se/hops/zeppelin-interpreter.tgz
                tar -xf zeppelin-interpreter.tgz
                mv zeppelin-interpreter #{node[:zeppelin][:home]}
                chown -R #{node[:zeppelin][:user]}:#{node[:zeppelin][:group]} #{node[:zeppelin][:home]}
                touch #{node[:zeppelin][:home]}/.zeppelin_extracted_#{node[:zeppelin][:version]}
        EOH
     not_if { ::File.exists?( "#{node[:zeppelin][:home]}/.zeppelin_extracted_#{node[:zeppelin][:version]}" ) }
end


link node[:zeppelin][:base_dir] do
  owner node[:zeppelin][:user]
  group node[:zeppelin][:group]
  to node[:zeppelin][:home]
end


my_ip = my_private_ip()
#spark_master_ip = private_recipe_ip("spark","master")
#flink_jobmgr_ip = private_recipe_ip("flink","jobmanager")

file "#{node[:zeppelin][:home]}/conf/zeppelin-env.sh" do
 action :delete
end

template "#{node[:zeppelin][:home]}/conf/zeppelin-env.sh" do
  source "zeppelin-env.sh.erb"
  owner node[:zeppelin][:user]
  group node[:zeppelin][:group]
  mode 0655
  variables({ 
        :private_ip => my_ip,
        :hadoop_dir => node[:hadoop][:base_dir],
        :spark_dir => node[:spark][:base_dir]
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
        :hadoop_home => node[:hadoop][:base_dir],
        :spark_home => node[:spark][:base_dir],
        :zeppelin_home => node[:zeppelin][:base_dir],
        :version => node[:zeppelin][:version]
           })
end

template "#{node[:zeppelin][:home]}/bin/alive.sh" do
  source "alive.sh.erb"
  owner node[:zeppelin][:user]  
  group node[:zeppelin][:group]
  mode 0755
  variables({ 
           })
end

directory "#{node[:zeppelin][:home]}/run" do
  owner node[:zeppelin][:user]
  group node[:zeppelin][:group]
  mode 0655
  mode "755"
  action :create
end

directory "#{node[:zeppelin][:home]}/logs" do
  owner node[:zeppelin][:user]
  group node[:zeppelin][:group]
  mode 0655
  mode "755"
  action :create
end
