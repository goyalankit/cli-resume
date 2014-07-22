cli-resume
==========

cil-resume is a sinatra backed application. It can pull information from your LinkedIn profile or you can put additional information that's not on your profile.

## Create your own resume

Fork and then clone the repo:
```
git clone git@github.com:goyalankit/cli-resume
```

### Configure LinkedIn

Make a developer app on LinkedIn at [LinkedIn Developer Network](https://www.linkedin.com/secure/developer) and get the following parameters. Either export the values or set them directly in [linkedin_config.rb](https://github.com/goyalankit/cli-resume/blob/master/config/linkedin_config.rb)
```
api_key = ENV['API_KEY']
api_secret = ENV['API_SECRET']
user_token = ENV['USER_TOKEN']
user_secret = ENV['USER_SECRET']
```
**Protip:** Don't commit your api keys

### Change projects.yml

Modify [projects.yml](https://github.com/goyalankit/cli-resume/blob/master/config/projects.yml) to include your own projects.

### Extending
To add new commands, simply create a method with command name in  [LinkedIn Class](https://github.com/goyalankit/cli-resume/blob/master/lib/models/linkedin.rb)

To add it to the help menu, add the command in message created in help method in LinkedIn Class.


### Run the app
```
# to install the dependencies, only need to do it once.
bundle install

# start the server
rackup
```

You can refer to [LinkedIn Profile Api](https://developer.linkedin.com/documents/profile-fields) for possible information that you can retrieve.
