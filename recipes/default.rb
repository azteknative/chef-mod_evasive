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

# Remove the RPM packaged config if necessary
file "#{node['apache']['dir']}/conf.d/mod_evasive.conf" do
  action :delete
  only_if { node['platform_family'] == "rhel" }
end

# Drop off debian-style config
%w{ conf
    load }.each do |ext|

  template "#{node['apache']['dir']}/mods-available/evasive20.#{ext}" do
    source "evasive.#{ext}.erb"
    owner "root"
    group "root"
    mode "0644"
  end
end

apache_module "evasive20"

