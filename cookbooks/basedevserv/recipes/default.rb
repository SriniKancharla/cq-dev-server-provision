#
# Cookbook Name:: basedevserv
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "java"
include_recipe "tomcat_latest"
include_recipe "apache2"
include_recipe "subversion"
include_recipe "git::server"
#include_recipe "openldap::server"
include_recipe "subversion::client"