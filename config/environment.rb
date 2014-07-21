require 'erb'
require 'yaml'

#here you can load yaml files in config folder
projects_path = File.expand_path(File.join(File.dirname(__FILE__), 'projects.yml'))
PROJECTS = YAML.load_file(projects_path)
require 'pry'; binding.pry
