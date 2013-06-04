bash "update resources" do
  code <<-EOH
  apt-get update
  EOH
end

%w[git vim emacs ruby screen].each do |pkg|
  package pkg do
    action :install
  end
end

git "/etc/dotfiles" do
  repository "git://github.com/nickcanz/dotfiles.git"
  reference "master"
  action :sync
end

%w[rake bundler].each do |gem|
  gem_package gem do
    action :install
  end
end

bash "install dotfiles" do
  cwd "/etc/dotfiles"
  code <<-EOH
  rake install
  EOH
end
