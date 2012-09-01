name "nexus"
description "Role that sets up the Nexus artifact server"
run_list "recipe[apt]", "recipe[nexus]"
default_attributes :nexus => { :listen_port => "8081" }
