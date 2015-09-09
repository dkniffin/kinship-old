# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'
require 'yaml'

# Default admin user
User.create email: 'admin@nowhere.com', password: 'kinship123', role: 'admin'

# Default settings
settings_file = File.join(File.dirname(File.expand_path(__FILE__)),'settings_defaults.yml')
YAML.load_file(settings_file).each do |k,v|
  Setting.create(var: k, value: v)
end
