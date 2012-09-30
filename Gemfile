source 'https://rubygems.org'

# Infrastructure
gem 'rails', '3.2.7'
gem 'pg'
gem 'heroku'
gem 'lol_dba'

# Authentication
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'

# Javascript
gem 'jquery-rails'
gem 'jquery-tokeninput-rails'
gem "select2-rails", "~> 3.1.1"

# Forms
gem 'haml-rails'
gem 'bootstrap-sass', "~> 2.0.4.2"
gem 'compass-rails'
gem 'simple_form'
gem 'ckeditor', '3.7.2'

# Other
gem 'friendly_id'
gem 'carrierwave'
gem 'mini_magick'
gem 'carmen-rails', '~> 1.0.0.beta3'
gem 'rmagick', '2.13.1'
gem 'fog'
gem 'activerecord-reputation-system', require: 'reputation_system'
gem 'ancestry'
gem 'taps'
gem 'hirb'

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
end

group :development, :test do
  gem 'rspec-rails'
  gem 'mocha'
  gem 'spork'
  gem 'faker'
  gem 'populator'
  gem 'annotate'
  gem 'shoulda-matchers' # shoulda-context causes the error http://stackoverflow.com/q/9523931/238880
  gem 'factory_girl_rails'  # Used for seeding data also
  gem 'autotest-rails'
end

group :test do
  gem 'email_spec'
  gem 'cucumber-rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
end

group :production do
  gem 'unicorn'
  gem 'newrelic_rpm'
end

# To use Jbuilder templates for JSON
# gem 'jbuilder'
