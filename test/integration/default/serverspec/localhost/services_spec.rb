require 'spec_helper'

describe service('namenode') do  
  it { should be_enabled   }
  it { should be_running   }
end 

describe service('datanode') do  
  it { should be_enabled   }
  it { should be_running   }
end 

describe command("jps") do
  its (:stdout) { should match /Master/ }
  its (:stdout) { should match /Worker/ }
end

