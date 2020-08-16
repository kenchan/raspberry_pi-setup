execute 'install softether vpn' do
  user 'root'
  command '
    wget -O /tmp/vpnserver.tar.gz https://jp.softether-download.com/files/softether/v4.34-9745-rtm-2020.04.05-tree/Linux/SoftEther_VPN_Server/32bit_-_ARM_EABI/softether-vpnserver-v4.34-9745-rtm-2020.04.05-linux-arm_eabi-32bit.tar.gz &&
    tar -zxf /tmp/vpnserver.tar.gz -C /tmp &&
    cd /tmp/vpnserver &&
    yes 1 | make &&
    cd /tmp &&
    mv vpnserver /usr/local &&
    rm vpnserver.tar.gz
  '
  not_if 'test -d /usr/local/vpnserver'
end

remote_file '/etc/systemd/system/vpnserver.service' do
  action :create
  owner 'root'
  content 'files/vpnserver.service'
  notifies :run, 'execute[systemctl daemon-reload]', :immediately
end

execute 'systemctl daemon-reload' do
  action :nothing
end

service 'vpnserver' do
  action [:enable, :start]
end
