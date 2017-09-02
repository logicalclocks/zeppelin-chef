
hopsworks_user= node['install']['user'].empty? ? "glassfish" : node['install']['user']
if node.attribute?('hopsworks') == true
  if node['hopsworks'].attribute?('user') == true
    hopsworks_user = node['hopsworks']['user']
  end
end


directory node['zeppelin']['base_dir'] + "/Projects" do
  owner hopsworks_user
  group node['hops']['group']
  mode "0710"
  action :create
end
