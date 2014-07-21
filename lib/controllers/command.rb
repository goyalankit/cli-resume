class ResumeCli::Controllers::Command < Sinatra::Base
  require 'json'
  #set view directory as /views/commands for this controller views
  set :views,  File.join(root, '../views/commands' )
  Linkedin = ResumeCli::Models::Linkedin

  def send_to_terminal message
    content_type :json
    {result: message}.to_json
  end

  #  add your own routes TODO
    get '/' do
      erb :index
    end

    get '/command/*' do
      #begin
        send_to_terminal(Linkedin.instance_eval(params['command']))
      #rescue NameError => e
        #send_to_terminal("command not supported.\ntype [[;white;]help] to list supported commands")
      #end
    end
end

