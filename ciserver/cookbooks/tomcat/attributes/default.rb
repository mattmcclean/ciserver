#
# Cookbook Name:: tomcat
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

default["tomcat"]["version"] = "7.0.29"
default["tomcat"]["tarfile"] = "apache-tomcat-#{tomcat["version"]}.tar.gz"
default["tomcat"]["url"] = "http://mirror.nohup.it/apache/tomcat/tomcat-7/v7.0.29/bin/#{tomcat["tarfile"]}"
default["tomcat"]["checksum"] = "307076fa3827e19fa9b03f3ef7cf1f3f"
default["tomcat"]["homedir"] = "/usr/local/tomcat"
default["tomcat"]["confdir"] = "/usr/local/tomcat/conf"

default["tomcat"]["http_port"] = "8082"
default["tomcat"]["ajp_port"] = "8010"

