#
# Cookbook Name:: nexus
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

default["nexus"]["version"] = "2.1.1"
default["nexus"]["tarfile"] = "nexus-#{nexus["version"]}-bundle.tar.gz"
default["nexus"]["url"] = "http://www.sonatype.org/downloads/#{nexus["tarfile"]}"
default["nexus"]["checksum"] = "7a6c0e2bd736ca7dc6803c454136e12153fbdcd3df29ac34858a272f0b7bfd59"
default["nexus"]["homedir"] = "/usr/local/nexus"
default["nexus"]["listen_port"] = "8081"

