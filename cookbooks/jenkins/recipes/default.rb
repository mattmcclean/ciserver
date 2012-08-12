#
# Cookbook Name:: jenkins
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

group "jenkins" do
  system true
end

user "jenkins" do
  gid "jenkins"
  system true
  shell "/bin/false"
end

directory node[:jenkins][:homedir] do
  mode "0755"
  owner "jenkins"
  group "jenkins"
  action :create
end

directory node[:jenkins][:logdir] do
  mode "0755"
  owner "jenkins"
  group "jenkins"
  action :create
end

directory node[:jenkins][:rundir] do
  mode "0755"
  owner "jenkins"
  group "jenkins"
  action :create
end

directory node[:jenkins][:libdir] do
  mode "0755"
  owner "jenkins"
  group "jenkins"
  action :create
end

remote_file "#{node[:jenkins][:libdir]}/jenkins.war" do
  source node['jenkins']['url']
  checksum node['jenkins']['checksum']
  owner 'jenkins'
  group 'jenkins'
  action :create
end

template "/etc/init/jenkins.conf" do
  source "jenkins.conf.erb"
  owner "root"
  group "root"
  mode 0644
  variables({
    :webport => node[:jenkins][:port],
    :java_opts => node[:jenkins][:java_opts]
  })
end

service "jenkins" do
    provider Chef::Provider::Service::Upstart
    enabled true
    running true
    supports :restart => true, :reload => true, :status => true
    action [:enable, :start]
end
