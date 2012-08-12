#
# Cookbook Name:: jenkins
# Recipe:: buildserver
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

include_recipe "jenkins"

directory "#{node[:jenkins][:m2][:envdir]}" do
  owner "jenkins"
  group "jenkins"
  mode "0755"
end

directory "#{node[:jenkins][:m2][:envdir]}/repository" do
  owner "jenkins"
  group "jenkins"
  mode "0755"
end

cookbook_file "#{node[:jenkins][:m2][:envdir]}/settings.xml" do
  source "settings.xml"
  owner "jenkins"
  group "jenkins"
  mode "0755"
end

jenkins_update

jenkins_plugin "release"

jenkins_plugin "github"

template "/tmp/setup_tools.groovy" do
  source "setup_tools.groovy.erb"
  owner "jenkins"
  group "jenkins"
  mode "0744"
end

jenkins_cli "groovy /tmp/setup_tools.groovy"

# Setup git on machine
package "git"

jenkins_submit_job "build-and-release-#{node[:jenkins][:project][:artifactId]}" do
  source "build-and-release-project-config.xml"
end

jenkins_submit_job "deploy-#{node[:jenkins][:project][:artifactId]}" do
  source "deploy-project-config.xml"
end
  
upload_jar_to_nexus "prevayler.jar" do
  source "https://github.com/downloads/mattmcclean/companyNews/prevayler-2.3.jar"
  user "jenkins"
  group "jenkins"
  groupId "org.prevayler"
  artifactId "prevayler"
  version "2.3"
end
