require 'pp'

namespace :data do

  desc 'Import skills from db/data/skills.csv to skills database table'
  task :import_skills => :environment do
    rows = File.new("#{Rails.root}/db/data/skills.tsv", "r:UTF-8").readlines
    rows.delete_at(0)
    Skill.transaction do
      rows.each do |row|
        id, name, description, category, is_deprecated = row.split("\t")
        h = {
          :id => id,
          :name => name,
          :description => description,
          :category => category.strip,
          :is_deprecated => is_deprecated.to_s.strip.to_i,
        }
        pp h
        Skill.create!(h)
      end
    end
  end

end