#
# Cookbook Name:: jenkins
# Definition:: upload_jar_to_nexus.rb
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

define :upload_jar_to_nexus, :enable => true, :packaging => "jar", :repositoryId => "deployment", :nexus_url => "http://localhost:8081/nexus/content/repositories/thirdparty" do
  include_recipe "maven"

  if params[:cwd] != nil
    cwd_dir = params[:cwd]
  elsif params[:user] != nil
    cwd_dir = "/home/#{params[:user]}"
  else
    cwd_dir = "/tmp"
  end

  build_dir = "#{cwd_dir}/.upload_jar"

  directory build_dir do
    unless params[:user].nil?
      user params[:user]
    end
    unless params[:group].nil?
      group params[:group]
    end
    mode "0755"
  end

  uploaded_jars_dir = "#{build_dir}/uploaded-jars"
  directory uploaded_jars_dir do
    unless params[:user].nil?
      user params[:user]
    end
    unless params[:group].nil?
      group params[:group]
    end
    mode "0755"
  end

  local_file = "#{build_dir}/#{params[:name]}"
  remote_file local_file do
    source params[:source]
  end
  
  if params[:enable]
    execute "uploading jar #{params[:name]} to server #{params[:nexus_url]}" do
      command "mvn deploy:deploy-file -DgroupId=#{params[:groupId]} -DartifactId=#{params[:artifactId]} -Dversion=#{params[:version]} -Dpackaging=#{params[:packaging]} -Dfile=#{local_file} -DrepositoryId=#{params[:repositoryId]} -Durl=#{params[:nexus_url]} && touch #{uploaded_jars_dir}/#{params[:name]}"
      unless params[:user].nil?
        user params[:user]
      end
      unless params[:group].nil?
        group params[:group]
      end
      cwd build_dir
      creates "#{uploaded_jars_dir}/#{params[:name]}"
    end
  end
end
