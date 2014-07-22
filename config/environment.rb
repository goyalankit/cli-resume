require 'erb'
require 'yaml'

#here you can load yaml files in config folder
projects_path = File.expand_path(File.join(File.dirname(__FILE__), 'projects.yml'))
links_path = File.expand_path(File.join(File.dirname(__FILE__), 'links.yml'))
PROJECTS = YAML.load_file(projects_path)
LINKS = YAML.load_file(links_path)
