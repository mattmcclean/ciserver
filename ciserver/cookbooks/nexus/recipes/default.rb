#
# Cookbook Name:: nexus
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

group "nexus" do
  system true
end

user "nexus" do
  gid "nexus"
  system true
  shell "/bin/false"
end

directory "/usr/local/sonatype-work/nexus" do
  mode "0755"
  owner "nexus"
  group "nexus"
  action :create
  recursive true
end

ark "nexus" do
  url node['nexus']['url']
  checksum node['nexus']['checksum']
  home_dir node['nexus']['homedir']
  version node['nexus']['version']
  owner 'nexus'
  action :install
end

cookbook_file "/etc/init/nexus.conf" do
  source "nexus.conf"
  owner "root"
  group "root"
  mode 0644
end

service "nexus" do
    provider Chef::Provider::Service::Upstart
    enabled true
    running true
    supports :restart => true, :reload => true, :status => true
    action [:enable, :start]
end
