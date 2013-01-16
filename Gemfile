source 'https://rubygems.org'

# Infrastructure
gem 'rails', '3.2.11'
gem 'pg'
gem 'heroku'
gem 'lol_dba'
gem 'airbrake'
gem 'activerecord-postgres-hstore'
gem 'dalli'
gem 'bloggy'

# Authentication & Authorization
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'cancan'

# Javascript
gem 'jquery-rails'
gem 'jquery-tokeninput-rails'
gem "select2-rails", "~> 3.1.1"

# Forms
gem 'haml-rails'
gem 'bootstrap-sass', "~> 2.0.4.2"
gem 'compass-rails'
gem 'simple_form'
gem 'jquery-datatables-rails', github: 'rweng/jquery-datatables-rails'
gem 'jquery-ui-rails'
gem 'will_paginate'
gem 'rails_autolink'
gem 'redcarpet'
gem 'albino'
gem 'nokogiri'
gem 'markitup-rails'

# Other
gem 'friendly_id'
gem 'carrierwave', '0.7.1'
gem 'mini_magick'
gem 'carmen-rails', '~> 1.0.0.beta3'
gem 'rmagick', '2.13.1'
gem 'fog', '1.7.0'
gem 'activerecord-reputation-system', require: 'reputation_system'
gem 'ancestry'
gem 'premailer-rails3'
gem 'hpricot'
gem 'taps'
gem 'hirb'
gem 'bullet', '~> 4.2.0'
gem "queue_classic", '2.0.3'
gem "hirefireapp", git: "git://github.com/meskyanichi/hirefireapp.git", branch: "develop"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem "travis-lint", "~> 1.4.0"
  gem 'debugger'
  gem "better_errors"
  gem "binding_of_caller"
end

group :development, :test do
  gem 'rspec-rails'
  gem 'faker'
  gem 'populator'
  gem 'annotate'
  gem 'shoulda-matchers' # shoulda-context causes the error http://stackoverflow.com/q/9523931/238880
  gem 'factory_girl_rails'  # Used for seeding data also
  gem 'autotest-rails'

  gem 'rb-fsevent', require: false
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'guard-annotate'
  gem 'guard-bundler'
end

group :test do
  gem 'email_spec', "~> 1.2.1"
  gem 'cucumber-rails', require: false
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'spork-rails'
end

group :production do
  gem 'unicorn'
  gem 'newrelic_rpm', '3.5.3.25'
end

# To use Jbuilder templates for JSON
# gem 'jbuilder'
