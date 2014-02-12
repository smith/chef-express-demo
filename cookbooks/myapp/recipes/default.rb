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

execute 'apt-get update'

%w[ python-software-properties python g++ make ].each do |pkg|
  package pkg
end

execute 'add-apt-repository ppa:chris-lea/node.js'
execute 'apt-get update'

package 'nodejs'

execute 'npm install' do
  cwd '/vagrant'
  not_if { Dir.exist?('/vagrant/node_modules') }
end

template '/etc/init/myapp.conf' do
  source 'myapp.conf.erb'
  variables(:port => 80)
end

service 'myapp' do
  provider Chef::Provider::Service::Upstart
  supports :enable => true, :disable => true, :start => true, :stop => true
  action [:enable, :start]
end
