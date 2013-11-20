module PeopleHelper
	def setup_person(person)
		person.birth ||= Birth.new
		person
	end
end
