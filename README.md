cli-resume
==========

cil-resume is a sinatra backed application. It can pull information from your LinkedIn profile or you can put additional information that's not on your profile.

## Create your own resume

Fork and then clone the repo:
```
git clone git@github.com:goyalankit/cli-resume
```

Make a developer app on LinkedIn at [LinkedIn Developer Network](https://www.linkedin.com/secure/developer) and get the following parameters. Either export the values or set them directly in [linkedin_config.rb](https://github.com/goyalankit/cli-resume/blob/master/config/linkedin_config.rb)
```
api_key = ENV['API_KEY']
api_secret = ENV['API_SECRET']
user_token = ENV['USER_TOKEN']
user_secret = ENV['USER_SECRET']
```

Run `bundle install` in the root of repo. 

## Start the server:
```
rackup
```

You can refer to [LinkedIn Profile Api](https://developer.linkedin.com/documents/profile-fields) for possible information that you can retrieve.
