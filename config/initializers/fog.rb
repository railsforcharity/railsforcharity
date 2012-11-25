CarrierWave.configure do |config|
  config.asset_host       = 'https://s3.amazonaws.com'              # optional, defaults to nil

  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['AM_ACCESS_KEY_ID'],
    :aws_secret_access_key  => ENV['AM_SECRET_ACCESS_KEY'],
    # :region                 => 'eu-west-1'  # optional, defaults to 'us-east-1'
  }

  config.fog_directory  = "RFC-#{Rails.env}"                      # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' }  # optional, defaults to {}
end