#
# Cookbook Name:: myapp
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Set up a repository where we can install node on Ubuntu. Based on instructions from
# https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager#wiki-ubuntu-mint-elementary-os

include_recipe 'apt'
include_recipe 'nodejs::install_from_package'

execute 'npm install' do
  cwd '/vagrant'
  not_if { Dir.exist?('/vagrant/node_modules') }
end

include_recipe 'runit'

runit_service 'myapp' do
  default_logger true
  env('PORT' => '80')
  action [:enable, :start]
end
