if Rails.env.production?
  Airbrake.configure do |config|
    config.api_key = ENV['AIBRAKE_API_KEY']
  end
end