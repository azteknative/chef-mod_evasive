#
# Cookbook Name:: mod_evasive
# Recipe:: default
#
# Copyright (C) 2015 AzTek Native Ltd.
#
# All rights reserved - Do Not Redistribute
#

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


