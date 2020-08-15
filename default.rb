execute 'apt-get update'
execute 'apt-get upgrade -y'

include_recipe 'raspi-config/default.rb'
include_recipe 'sshd/default.rb'
