#
# Cookbook Name:: basedevserv
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apache2"
include_recipe "java"
include_recipe "tomcat_latest"
include_recipe "subversion"
include_recipe "git::server"
include_recipe "openldap::server"
include_recipe "subversion::server"
include_recipe "jenkins::server"
include_recipe "nexus::default"

hostsfile_entry "127.0.1.1" do
  hostname "ldap.example.com"
  action :append
end

directory node[:openldap][:ssl_dir] do
  owner "root"
  group "root"
  mode 00755
  action :create
end

node[:certs].each do |c|
  cookbook_file c do
    backup false
    action :create_if_missing
    owner "root"
    group "root"
    mode 0644
  end
end