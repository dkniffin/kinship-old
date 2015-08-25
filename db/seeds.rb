# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'

User.create :email => 'nobody@none.com', :password => 'kinship'

# Default settings
Setting.create(var: 'site_header', value: 'Your Kinship Site')
Setting.create(var: 'homepage_blurb', value: <<-eos
<p>Welcome to your new genealogy site! This blurb is just a filler, until you
get around to putting your own content here. It can be configured through the
admin interface.</p>
eos
)
Setting.create(var: 'eventsFormat', value: 'timeline')
