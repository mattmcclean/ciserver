#
# Cookbook Name:: jenkins
# Definition:: jenkins_cli.rb
#
# Copyright 2012, Matt McClean

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

define :jenkins_cli, :enable => true do
  include_recipe "jenkins"
  include_recipe "jenkins::install_cli_jar"

  if params[:enable]
    execute "jenkins_cli #{params[:name]}" do
      command "#{node['jenkins']['cli_cmd']} #{params[:name]}"
    end
  end
end
