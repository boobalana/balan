#
# Cookbook Name:: user
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
user "sysuser" do
  comment "System user"
  home    "/home/sysuser"
  shell   "/bin/bash"
  supports :manage_home => true
  action [ :create, :manage ]
end

directory "/home/sysuser/.ssh" do
  owner "sysuser"
  group "sysuser"
  mode 0700
  action :create
  not_if { File.exists? "/home/sysuser/.ssh" }
end

cookbook_file "/home/sysuser/.ssh/id_rsa.pub" do
  source "id_rsa.pub"
  owner "sysuser"
  group "sysuser"
  mode  0640
  action :create
end

cookbook_file "/home/sysuser/.ssh/authorized_keys" do
  source "id_rsa.pub"
  owner "sysuser"
  group "sysuser"
  mode  0640
  action :create
end

group "root" do
action :modify
members "sysuser"
append true
end
