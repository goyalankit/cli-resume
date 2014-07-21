$: << 'lib'
require 'config/environment'
require 'config/linkedin_config'
require "sinatra/reloader"

module ResumeCli
  Dir[File.join(File.dirname(__FILE__), 'lib', '*.rb')].each do |f|
    autoload File.basename(f, '.rb').camelize.to_sym, f
  end

  module Controllers
    Dir[File.join(File.dirname(__FILE__), 'lib', 'controllers/*.rb')].each do |f|
      autoload File.basename(f, '.rb').camelize.to_sym, f
    end
  end

  module Models
    Dir[File.join(File.dirname(__FILE__), 'lib', 'models/*.rb')].each do |f|
      autoload File.basename(f, '.rb').camelize.to_sym, f
    end
  end
end
