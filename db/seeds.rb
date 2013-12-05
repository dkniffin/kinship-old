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

# Example people
person1 = Person.create(first_name: 'Helen', last_name: 'Mills', gender: 'F')
person2 = Person.create(first_name: 'Charles', last_name: 'Mills', gender: 'M')
Person.create(first_name: 'Cheryl', last_name: 'Mills', gender: 'F', :birth => Birth.create(father_id: person2.id, mother_id: person1.id))
person3 = Person.create(first_name: 'Claudia', last_name: 'Mills', gender: 'F', :birth => Birth.create(father_id: person2.id, mother_id: person1.id))
person4 = Person.create(first_name: 'Velma', last_name: 'Wahl', gender: 'F')
person5 = Person.create(first_name: 'Alfred', last_name: 'Wahl', gender: 'M')
Person.create(first_name: 'Jerry', last_name: 'Wahl', gender: 'M', :birth => Birth.create(father_id: person4.id, mother_id: person5.id))
person6 = Person.create(first_name: 'Richard', last_name: 'Wahl', gender: 'M', :birth => Birth.create(father_id: person4.id, mother_id: person5.id))
Person.create(first_name: 'Greg', last_name: 'Wahl', gender: 'M', :birth => Birth.create(father_id: person6.id, mother_id: person3.id))
Person.create(first_name: 'Christopher', last_name: 'Wahl', gender: 'M', :birth => Birth.create(father_id: person6.id, mother_id: person3.id))

# Default settings
Setting.create(var: 'homepage_blurb', value: <<-eos
<p>This is where the homepage blurb will go. It can be configured through the admin interface</p>
eos
)
Setting.create(var: 'eventsFormat', value: 'timeline')
Setting.create(var: 'site_header', value: 'kinship')

