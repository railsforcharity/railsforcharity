source 'https://rubygems.org'

gem 'rails', '3.2.7'
gem 'pg'
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'heroku'

gem 'haml-rails'
gem 'jquery-rails'
gem 'bootstrap-sass', "~> 2.0.4.2"
gem 'simple_form'
gem 'friendly_id'
gem 'compass-rails'
gem 'ckeditor', '3.7.2'
gem 'carrierwave'
gem 'mini_magick'


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
  gem 'hirb'
  gem 'shoulda-matchers' # shoulda-context causes the error http://stackoverflow.com/q/9523931/238880
  gem 'factory_girl_rails'  # Used for seeding data also
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
end

# To use Jbuilder templates for JSON
# gem 'jbuilder'
