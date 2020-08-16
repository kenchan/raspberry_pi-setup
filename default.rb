execute 'apt-get update'
execute 'apt-get upgrade -y'

include_recipe 'raspi-config/default.rb'
include_recipe 'sshd/default.rb'
include_recipe 'mackerel_agent/default.rb'
include_recipe 'softether/default.rb'
