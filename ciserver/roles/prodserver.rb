name "prodserver"
description "Role for setting up the production web server"
run_list "recipe[apt]", "recipe[tomcat]"
override_attributes(
  :tomcat => {
    :port => "8082",
    :ssl_port => "8444",
    :ajp_port => "8010"
  }
)
