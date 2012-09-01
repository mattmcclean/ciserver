#
# Cookbook Name:: jenkins
# Definition:: jenkins_update
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

define :jenkins_update, :enable => true do
  include_recipe "jenkins"

  package "wget"
  package "curl"

  if params[:enable]
    execute "install_jenkins_update" do
      command "sleep 10 && wget -qO- http://updates.jenkins-ci.org/update-center.json | sed '1d;$d' | curl -X POST -H \"Accept: application/json\" -d @- http://localhost:#{node[:jenkins][:port]}/updateCenter/byId/default/postBack --verbose && touch #{node[:jenkins][:rundir]}/.updated"
      not_if do ::File.exists?("#{node[:jenkins][:rundir]}/.updated") end    
    end
  end
end
