my_ip = my_private_ip()
nn_endpoint = private_recipe_ip("apache_hadoop", "nn") + ":#{node.apache_hadoop.nn.port}"

  
apache_hadoop_hdfs_directory "#{node.livy.home}/livy-assembly/target/scala-2.10/livy-assembly-#{node.livy.version}-SNAPSHOT.jar" do
  action :put_as_superuser
  owner node.hadoop_spark.user
  group node.apache_hadoop.group
  mode "1775"
  dest "#{home}/#{node.hadoop_spark.user}/livy-assembly.jar"
end



file "#{node.livy.home}/conf/livy-defaults.conf" do
 action :delete
end

template "#{node.livy.home}/conf/livy-defaults.conf" do
  source "livy-defaults.conf.erb"
  owner node.hadoop_spark.user
  group node.hadoop_spark.group
  mode 0655
  variables({ 
        :private_ip => my_ip,
        :nn_endpoint => nn_endpoint
           })
end


case node.platform
when "ubuntu"
 if node.platform_version.to_f <= 14.04
   node.override.hadoop_spark.systemd = "false"
 end
end


service_name="livy"

if node.hadoop_spark.systemd == "true"

  service service_name do
    provider Chef::Provider::Service::Systemd
    supports :restart => true, :stop => true, :start => true, :status => true
    action :nothing
  end

  case node.platform_family
  when "rhel"
    systemd_script = "/usr/lib/systemd/system/#{service_name}.service" 
  else
    systemd_script = "/lib/systemd/system/#{service_name}.service"
  end

  template systemd_script do
    source "#{service_name}.service.erb"
    owner "root"
    group "root"
    mode 0754
    notifies :enable, resources(:service => service_name)
    notifies :start, resources(:service => service_name), :immediately
  end

  hadoop_spark_start "reload_#{service_name}" do
    action :systemd_reload
  end  

else #sysv

  service service_name do
    provider Chef::Provider::Service::Init::Debian
    supports :restart => true, :stop => true, :start => true, :status => true
    action :nothing
  end

  template "/etc/init.d/#{service_name}" do
    source "#{service_name}.erb"
    owner node.hadoop_spark.yarn.user
    group node.hadoop_spark.group
    mode 0754
    notifies :enable, resources(:service => service_name)
    notifies :restart, resources(:service => service_name), :immediately
  end

end


if node.kagent.enabled == "true" 
   kagent_config service_name do
     service "YARN"
     start_script "service #{service_name} start"
     stop_script "service #{service_name} stop"
     log_file "#{node.livy.home}/livy.log"
     pid_file "#{node.livy.home}/livy.pid"
     web_port "#{node.livy.port}"
   end
end

