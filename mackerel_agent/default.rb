apt 'mackerel_plugin' do
  action :install
  source_url 'https://github.com/mackerelio/mackerel-agent/releases/download/v0.68.2/mackerel-agent_0.68.2-1.systemd_armhf.deb'
  not_if 'dpkg-query -W mackerel-agent &> /dev/null'
end

template '/etc/mackerel-agent/mackerel-agent.conf' do
  action :create
  user 'root'
  group 'root'
  source 'templates/mackerel-agent.conf.erb'
end

service 'mackerel-agent' do
  action [:start, :enable]
  subscribes :reload, 'template[/etc/mackerel-agent/mackerel-agent.conf]'
end
