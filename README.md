Rearden Notifier 
===============
Rearden Notifier is a gem that works with the Rearden bug tracking application.
Both Rearden and Rearden Notifier are open source applications that give you the
ability to customize your error tracking. 

Rearden Notifier can be used in 2 ways

Without Running your own Rearden Instance.
------------------------------------------
If you are looking for a free basic error tracking app, but do not want to run
your own rearden instance, the you can sign up for new account at rearden.herokuapp.com. After you sign up. Do the following.

In your application
    gem 'rearden_notifier'
Then
    rails g rearden_notifier:install

The generator installs configuration file in config/initializers

Log into you account on rearden.heroku.com
create a new project
When you create a new project, your project generates an application key.

Paste the new key into the initializer that was generated by the installer 

#TODO
Change so does not send in test by default
add config to test by default
recover from nils