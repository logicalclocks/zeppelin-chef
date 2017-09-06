action :start do

  bash "start-zeppelin" do
    user node['zeppelin']['user']
    group node['zeppelin']['group']
    code <<-EOF
      cd #{node['zeppelin']['home']}
      ./bin/zeppelin-daemon.sh start
    EOF
  end
 
end

action :stop do

  bash "stop-zeppelin" do
    user node['zeppelin']['user']
    group node['zeppelin']['group']
    code <<-EOF
      cd #{node['zeppelin']['home']}
      ./bin/zeppelin-daemon.sh stop
    EOF
  end
 
end
