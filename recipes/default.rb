#
# Cookbook Name:: mod_evasive
# Recipe:: default
#
# Copyright (C) 2015 AzTek Native Ltd.
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apache2"

if node['platform_family'] == "rhel"
  include_recipe "yum-epel"
end

# Install relevant package
pkg = value_for_platform(
  [ "centos", "fedora", "redhat" ] => {
    "default" => "mod_evasive"
  },
  [ "debian", "ubuntu" ] => {
    "default" => "libapache2-mod-evasive"
  }
)

package pkg do
  action :install
end

# Remove the packaged config if necessary
%w{ conf.d/mod_evasive.conf
    mods-available/evasive.conf
    mods-available/evasive.load }.each do |f|

  file "#{node['apache']['dir']}/#{f}" do
    action :delete
  end
end

# Remove symlinks created by apt-get
%w{ mods-enabled/evasive.conf
    mods-enabled/evasive.load }.each do |l|

  link "#{node['apache']['dir']}/#{l}" do
    action :delete
  end
end

# Drop off debian-style config
template "#{node['apache']['dir']}/mods-available/evasive20.conf" do
  source "evasive.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end

apache_module "evasive20"

