# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Admin user
User.create(username: 'admin', 
			email: 'nobody@none.com', 
			role: User::ROLE_ADMIN,
			password: 'kinship', 
			password_confirmation: 'kinship')

# Default settings
Setting.save_default(:homepage_blurb, <<-eos
<p>This is where the homepage blurb will go. It can be configured through the admin interface</p>
eos
)
