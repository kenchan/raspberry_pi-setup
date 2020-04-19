execute 'timedatectl set-timezone Asia/Tokyo' do
  not_if 'timedatectl show | grep -q Asia/Tokyo'
end

execute "locale-gen" do
  subscribes :edit, 'file[/etc/locale.gen]'
  action :nothing 
end

%w(
  ja_JP.UTF-8
  en_US.UTF-8
).each do |locale|
  file '/etc/locale.gen' do
    action :edit
    block do |content|
      content.gsub!("# #{locale}", locale)
    end
  end
end

execute 'localectl set-locale en_US.UTF-8' do
  not_if 'localectl | grep -v LANG=en_US.UTF-8'
end
