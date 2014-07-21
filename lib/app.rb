module ResumeCli
  class App < Sinatra::Base
    set :root, File.join(File.dirname(__FILE__), '..')
    set :vendor, 'FIX add your vendor name'

    use ResumeCli::Controllers::Command
  end
end

