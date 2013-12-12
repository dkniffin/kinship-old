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
rickard = Person.create(
	:first_name => 'Rickard', 
	:last_name => 'Stark', 
	:gender => 'M', 
	:birth => Birth.create(
		:place => Place.create(
			:place_string => 'Winterfell, The North, Westeros', 
			:lat => 56.9, 
			:lon => -3.8
		)
	), 
	:death => Death.create(
		:dead => true, 
		:date => '282-10-12'
	)
)
brandon = Person.create(
	:first_name => 'Brandon', 
	:last_name => 'Stark', 
	:gender => 'M', 
	:birth => Birth.create(
		:date => '261-07-05', 
		:father_id => rickard.id, 
		:place => Place.create(
			:place_string => 'Winterfell, The North, Westeros', 
			:lat => 56.9, 
			:lon => -3.8
		)
	), 
	:death => Death.create(
		:dead => true, 
		:date => '282-05-23', 
		:place => Place.create(
			:place_string => "King\'s Landing, The North, Westeros", 
			:lat => 53.9, 
			:lon => -2.5
		)
	)
)
lyanna = Person.create(
	:first_name => 'Lyanna', 
	:last_name => 'Stark', 
	:gender => 'F', 
	:birth => Birth.create(
		:date => '268-02-18', 
		:father_id => rickard.id, 
		:place => Place.create(
			:place_string => 'Winterfell, The North, Westeros', 
			:lat => 56.9, :lon => -3.8
		)
	), 
	:death => Death.create(
		:dead => true, 
		:date => '284-11-11'
	)
)
eddard = Person.create(
	:first_name => 'Eddard', 
	:last_name => 'Stark', 
	:gender => 'M', 
	:birth => Birth.create(
		:father_id => rickard.id, 
		:date => '263-08-30', 
		:place => Place.create(
			:place_string => 'Winterfell, The North, Westeros', 
			:lat => 56.9, 
			:lon => -3.8
		)
	), 
	:death => Death.create(
		:dead => true, 
		:date => '298-09-03', 
		:cause => 'Executed at order of Joffrey', 
		:place => Place.create(
			:place_string => "King\'s Landing, The North, Westeros", 
			:lat => 53.9, 
			:lon => -2.5
		)
	)
)
catelyn = Person.create(
	:first_name => 'Catelyn', 
	:last_name => 'Tulley', 
	:gender => 'F', 
	:spouse_id => eddard.id, 
	:birth => Birth.create(
		:date => '264-03-08', 
		:place => Place.create(
			:place_string => 'Riverrun, Riverlands, Westeros', 
			:lat => 55, 
			:lon => 4.2
		)
	), 
	:death => Death.create(
		:dead => true, 
		:date => '299-09-12', 
		:cause => 'The Red Wedding'
	)
)
jeyne = Person.create(
	:first_name => 'Jeyne', 
	:last_name => 'Westerling', 
	:gender => 'F', 
	:birth => Birth.create(
		:date => '284-12-15'
	), 
	:death => Death.create(
		:dead => true, 
		:date => '299-09-12', 
		:cause => 'The Red Wedding'
	)
)
robb = Person.create(
	:first_name => 'Robb', 
	:last_name => 'Stark', 
	:gender => 'M', 
	:spouse_id => jeyne.id, 
	:birth => Birth.create(
		:date => '283-01-01', 
		:father_id => eddard.id, 
		:mother_id => catelyn.id, 
		:place => Place.create(
			:place_string => 'Winterfell, The North, Westeros', 
			:lat => 56.9, 
			:lon => -3.8
		)
	), 
	:death => Death.create(
		:dead => true, 
		:date => '299-09-12', 
		:cause => 'The Red Wedding'
	)
)
bran = Person.create(
	:first_name => 'Bran', 
	:last_name => 'Stark', 
	:gender => 'M', 
	:birth => Birth.create(
		:father_id => eddard.id, 
		:mother_id => catelyn.id, 
		:date => '291-02-20', 
		:place => Place.create(
			:place_string => 'Winterfell, The North, Westeros', 
			:lat => 56.9, 
			:lon => -3.8
		)
	)
)
sansa = Person.create(
	:first_name => 'Sansa', 
	:last_name => 'Stark', 
	:gender => 'F', 
	:birth => Birth.create(
		:father_id => eddard.id, 
		:mother_id => catelyn.id, 
		:date => '286-08-13', 
		:place => Place.create(
			:place_string => 'Winterfell, The North, Westeros', 
			:lat => 56.9, 
			:lon => -3.8
		)
	)
)
arya = Person.create(
	:first_name => 'Arya', 
	:last_name => 'Stark', 
	:gender => 'F', 
	:birth => Birth.create(
		:father_id => eddard.id, 
		:mother_id => catelyn.id, 
		:date => '289-06-26', 
		:place => Place.create(
			:place_string => 'Winterfell, The North, Westeros', 
			:lat => 56.9, 
			:lon => -3.8
		)
	)
)
rickon = Person.create(
	:first_name => 'Rickon', 
	:last_name => 'Stark', 
	:gender => 'M', 
	:birth => Birth.create(
		:father_id => eddard.id, 
		:mother_id => catelyn.id, 
		:date => '295-06-13', 
		:place => Place.create(
			:place_string => 'Winterfell, The North, Westeros', 
			:lat => 56.9, 
			:lon => -3.8
		)
	)
)
jon = Person.create(
	:first_name => 'Jon', 
	:last_name => 'Snow', 
	:gender => 'M', 
	:birth => Birth.create(
		:father_id => eddard.id, 
		:date => '295-10-19'
	)
)

all_seeded_people = [rickard, brandon, lyanna, eddard, catelyn, jeyne, robb, bran, sansa, arya, rickon, jon]
all_seeded_people.each do |person|
  filename = "#{Rails.root}/app/assets/images/#{person.first_name.downcase}-#{person.last_name.downcase}.png"
  if File.exist?(filename)
    person.photo = File.open(filename)
    person.save
  end
end


# Default settings
Setting.create(var: 'homepage_blurb', value: <<-eos
<p>This is where the homepage blurb will go. It can be configured through the admin interface</p>
eos
)
Setting.create(var: 'eventsFormat', value: 'timeline')
Setting.create(var: 'site_header', value: 'kinship')

