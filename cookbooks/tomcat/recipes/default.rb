#
# Cookbook Name:: tomcat
# Recipe:: default
#
# Copyright 2012, Matthew McClean
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "java"

group "tomcat" do
  system true
end

user "tomcat" do
  gid "tomcat"
  system true
  shell "/bin/false"
end

ark "tomcat" do
  url node['tomcat']['url']
#  checksum node['tomcat']['checksum']
  home_dir node['tomcat']['homedir']
  version node['tomcat']['version']
  owner 'tomcat'
  group 'tomcat'
  action :install
end

template "#{node[:tomcat][:confdir]}/server.xml" do
  source "server.xml.erb"
  owner "tomcat"
  group "tomcat"
  mode 0644
  notifies :restart, "service[tomcat]"
end

template "#{node[:tomcat][:confdir]}/tomcat-users.xml" do
  source "tomcat-users.xml.erb"
  owner "tomcat"
  group "tomcat"
  mode 0644
  variables(
    :users => [ { 'id' => 'tomcat', 'password' => 'tomcat', 'roles' => "manager-gui,admin,manager-script" } ], 
    :roles => [ "manager-gui", "admin", "manager-script", "manager-status" ]
  )
  notifies :restart, "service[tomcat]"
end

cookbook_file "/etc/init.d/tomcat" do
  source "init.d/tomcat"
  owner "root"
  group "root"
  mode 0744
end

service "tomcat" do
    enabled true
    running true
    supports :restart => true
    action :enable
end

