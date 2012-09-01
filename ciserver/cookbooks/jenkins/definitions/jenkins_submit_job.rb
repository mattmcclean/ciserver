#
# Cookbook Name:: jenkins
# Definition:: jenkins_submit_job.rb
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

define :jenkins_submit_job, :enable => true do
  include_recipe "jenkins"
  include_recipe "jenkins::install_cli_jar"

  directory "#{node[:jenkins][:rundir]}/submitted-jobs" do
    owner "jenkins"
    group "jenkins"
    mode "0644"
  end

  source_file = "/tmp/#{params[:source]}"

  template source_file do
    source "jobs/#{params[:source]}.erb"
    owner "jenkins"
    group "jenkins"
    mode "0644"
  end

  if params[:enable]
    execute "submitting job #{params[:name]}" do
      command "#{node[:jenkins][:cli_cmd]} create-job #{params[:name]} < #{source_file}"
      not_if do ::File.exists?("#{node[:jenkins][:homedir]}/.jenkins/jobs/#{params[:name]}") end
    end
  end
end
