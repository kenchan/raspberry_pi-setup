file '/etc/ssh/sshd_config' do
  action :edit
  block do |content|
    content << 'PasswordAuthentication no' unless content =~ /^PasswordAuthentication no$/
  end
end

service 'sshd' do
  action :nothing
  subscribes :reload, 'file[/etc/ssh/sshd_config]'
end
