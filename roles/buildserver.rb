name "buildserver"
description "Role for the build server with continuous integration and maven"
run_list "recipe[apt]", "recipe[java]", "recipe[ant]", "recipe[maven]", "recipe[nexus]","recipe[jenkins::buildserver]"
override_attributes(
  :maven => {
    :version => "3"
  }
)
