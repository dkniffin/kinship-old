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
rickard = Person.create(:first_name => 'Rickard', :last_name => 'Stark', :gender => 'M', :death => Death.create(:dead => true, :date => '282-01-01'))
brandon = Person.create(:first_name => 'Brandon', :last_name => 'Stark', :gender => 'M', :birth => Birth.create(:date => '261-01-01', :father_id => rickard.id), :death => Death.create(:dead => true, :date => '282-01-01'))
lyanna = Person.create(:first_name => 'Lyanna', :last_name => 'Stark', :gender => 'F', :birth => Birth.create(:date => '268-01-01', :father_id => rickard.id), :death => Death.create(:dead => true, :date => '284-01-01'))
eddard = Person.create(:first_name => 'Eddard', :last_name => 'Stark', :gender => 'M', :birth => Birth.create(:father_id => rickard.id, :date => '263-01-01'), :death => Death.create(:dead => true, :date => '298-01-01', :cause => 'Executed at order of Joffrey'), :photo => File.open("#{Rails.root}/app/assets/images/eddard-stark.png"))
catelyn = Person.create(:first_name => 'Catelyn', :last_name => 'Tulley', :gender => 'F', :spouse_id => eddard.id, :birth => Birth.create(:date => '264-01-01'), :death => Death.create(:dead => true, :date => '299-01-1', :cause => 'The Red Wedding'))
jeyne = Person.create(:first_name => 'Jeyne', :last_name => 'Westerling', :gender => 'F', :birth => Birth.create( :date => '284-01-01'), :death => Death.create(:dead => true, :date => '299-01-01',:cause => 'The Red Wedding'))
robb = Person.create(:first_name => 'Robb', :last_name => 'Stark', :gender => 'M', :spouse_id => jeyne.id, :birth => Birth.create(:date => '283-01-01', :father_id => eddard.id, :mother_id => catelyn.id), :death => Death.create(:dead => true, :date => '299-01-01', :cause => 'The Red Wedding'))
bran = Person.create(:first_name => 'Bran', :last_name => 'Stark', :gender => 'M', :birth => Birth.create(:father_id => eddard.id, :mother_id => catelyn.id, :date => '291-01-01'))
sansa = Person.create(:first_name => 'Sansa', :last_name => 'Stark', :gender => 'F', :birth => Birth.create(:father_id => eddard.id, :mother_id => catelyn.id, :date => '286-01-01'))
arya = Person.create(:first_name => 'Arya', :last_name => 'Stark', :gender => 'F', :birth => Birth.create(:father_id => eddard.id, :mother_id => catelyn.id, :date => '289-01-01'))
rickon = Person.create(:first_name => 'Rickon', :last_name => 'Stark', :gender => 'M', :birth => Birth.create(:father_id => eddard.id, :mother_id => catelyn.id, :date => '295-01-01'))
jon = Person.create(:first_name => 'Jon', :last_name => 'Snow', :gender => 'M', :birth => Birth.create(:father_id => eddard.id, :date => '295-01-01'))

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

