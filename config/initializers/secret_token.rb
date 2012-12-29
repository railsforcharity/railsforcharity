# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
if !Rails.env.development? && !Rails.env.test?
  secret = ENV['APP_SECRET_TOKEN']
  if secret.blank?
    Rails.logger.info 'Please specify APP_SECRET_TOKEN in your environment. You can generate it using the "bundle exec rake secret" command'
    Rails.logger.info "For heroku, you can set it using the command 'heroku config:add APP_SECRET_TOKEN=yournewsecret'"
    raise
  end
else
  Rails.logger.info "Setting default secret"
  secret = 'f8207822f8de3a7c189fa11ce0d01dca32a02e70b5975800c3299c2c23d36b8677fce8412c2cff70d652896134ea5e37939e4022d6638754f6fb24a4ee77601a'
end

Railsforcharity::Application.config.secret_token = secret
