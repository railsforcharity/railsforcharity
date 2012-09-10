require 'pp'

namespace :heroku do

  # This task assumes that you have a ~/.private_settings/#{app_name}/#{Rails.env} file
  desc 'Set environment variables on heroku'
  task :load_variables => :environment do
    app_name = Rails.root.to_s.split('/').last
    lines = File.open("#{Dir.home}/.private_settings/#{app_name}/#{Rails.env}").readlines
    vars = []

    lines.each do |v|
      v.strip!
      next if v.blank? || v[0] == '#'
      v.gsub!('export', 'add')
      "Loading variable #{v.split('add')[1].strip}"
      vars << v.split.last
    end

    system "heroku config:add #{vars.join(' ')}"
  end
end
