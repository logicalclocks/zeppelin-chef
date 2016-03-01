bash 'kill_running_interpreters' do
    user "root"
    ignore_failure true
    code <<-EOF
      pkillall -9 Interpreter
    EOF
end


directory node.zeppelin.home do
  recursive true
  action :delete
  ignore_failure true
end

link node.zeppelin.base_dir do
  action :delete
  ignore_failure true
end


