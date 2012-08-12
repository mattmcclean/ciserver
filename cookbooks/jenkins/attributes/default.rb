#
# Cookbook Name:: jenkins
# Attributes:: default
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

default["jenkins"]["version"] = "1.477"
default["jenkins"]["warfile"] = "jenkins.war"
default["jenkins"]["port"] = "8080"
default["jenkins"]["url"] = "http://ftp.icm.edu.pl/packages/jenkins/war/#{node[:jenkins][:version]}/jenkins.war"
default["jenkins"]["checksum"] = "3330beb7fef7f1bd9509a66bf9d0da90b68ded08cf1f2b9e306e7790d035d505"
default["jenkins"]["homedir"] = "/home/jenkins"
default["jenkins"]["logdir"] = "/var/log/jenkins"
default["jenkins"]["rundir"] = "/var/run/jenkins"
default["jenkins"]["libdir"] = "/var/lib/jenkins"

default["jenkins"]["m2"]["envdir"] = "#{node[:jenkins][:homedir]}/.m2"
default["jenkins"]["maven"]["name"] = "maven_3.0.4"
default["jenkins"]["maven"]["home"] = "/usr/local/maven-3.0.4"
default["jenkins"]["ant"]["name"] = "ant_1.8.2"
default["jenkins"]["ant"]["home"] = "/usr/share/ant"

default["jenkins"]["cli_jar"] = "#{node[:jenkins][:libdir]}/jenkins-cli.jar"
default["jenkins"]["cli_cmd"] = "/usr/bin/java -jar #{node[:jenkins][:cli_jar]} -s http://localhost:#{node[:jenkins][:port]}"

default["jenkins"]["git"]["name"] = "mattmcclean"
default["jenkins"]["git"]["email"] = "matt.mcclean@gmail.com"

default["jenkins"]["project"]["git_url"] = "https://github.com/mattmcclean/tw-devops-assignment"
default["jenkins"]["project"]["pom"] = "companyNews/pom.xml"
default["jenkins"]["project"]["groupId"] = "com.example"
default["jenkins"]["project"]["artifactId"] = "companyNews"
