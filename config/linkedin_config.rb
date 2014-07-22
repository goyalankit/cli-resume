require 'rubygems'
require 'oauth'

# Fill the keys and secrets you retrieved after registering your app

api_key = ENV['API_KEY']
api_secret = ENV['API_SECRET']
user_token = ENV['USER_TOKEN']
user_secret = ENV['USER_SECRET']
 
# Specify LinkedIn API endpoint
configuration = { :site => 'https://api.linkedin.com' }
 
# Use your API key and secret to instantiate consumer object
consumer = OAuth::Consumer.new(api_key, api_secret, configuration)
 
# Use your developer token and secret to instantiate access token object
$linkedin = OAuth::AccessToken.new(consumer, user_token, user_secret)
