---
layout: post
title: Setting up Active Admin with existing User model
---

# Setting up Active Admin with existing User model  

**Gemfile**
    gem 'activeadmin'  

**Install gem**
    $ bundle install

**Run Generator** (to re-use existing users table)
    $ rails g active_admin:install --skip-users

**Migrate Database**
    $ bundle exec rake db:migrate

**Precompile assets for deployment environment (heroku)**
Add the following line to `config/environments/production.rb`  
    config.assets.precompile += ['active_admin.js', 'active_admin.css', 'active_admin/print.css']

**For heroku, turn on serving static assets**
    config.serve_static_assets = true

**Update** `config/initializers/active_admin.rb`  
  Reference: [http://stackoverflow.com/a/14651686/238880](http://stackoverflow.com/a/14651686/238880)

- config.current_user_method = :current_user
- config.logout_link_path = :destroy_user_session_path
- config.logout_link_method = :delete  

This last change is required if the default HTTP method used by your devise config is set to `:delete`, which it is unless you changed it. It matters that they are now synced because if you follow these instructions, you will be using `destroy_user_session_path` which is a path already defined by devise. Otherwise you will get a message stating that `[GET] /users/sign_out` route does not exist.

**Update** `app/models/user.rb`  
    def is_admin?
      self.email && ENV['ADMIN_EMAILS'].to_s.include?(self.email)
    end

**Update** `application_controller.rb`
    def authenticate_admin_user!
      redirect_to new_user_session_path unless current_user.try(:is_admin?)
    end

**Add the admin link in nav bar**
    - if current_user.is_admin?
      = link_to 'Admin', admin_dashboard_path

**Generate resources for each model you need to have administration for**  
`rails g active_admin:resource <Model Name>`

Examples:  
    $ rails g active_admin:resource User  
    $ rails g active_admin:resource Hub

**Start server and verify**  
`$ bundle exec rails s`  
When you are testing, make sure you set the environment variable `ADMIN_EMAILS` with the comma separated email ids of the admin users you want to grant access to

**Set environment variable in production**  
Set the `ADMIN_EMAILS` environment variable when you deploy

**And lastly, don't forget to migrate the database in production**