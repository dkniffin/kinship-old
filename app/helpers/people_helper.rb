module PeopleHelper
	def setup_person(person)
		person.birth ||= Birth.new
		person
	end

  def get_json_tree(person)
    @json_tree = "{ \"name\": \"#{person.full_name}\""
    children_ids = Birth.find_all_by_father_id(person.id).map {|elt| elt.child_id}
    children_ids += Birth.find_all_by_mother_id(person.id).map {|elt| elt.child_id}
    children = Person.find_all_by_id(children_ids)
    if !children.empty?
       @json_tree = "{ \"name\": \"#{person.full_name}\", \"children\": ["
       children.each do |child|
         @json_tree += get_json_tree(child)
         if child != children.last
           @json_tree += ','
         end
       end
       @json_tree += ']}'
    else
      @json_tree = "{ \"name\": \"#{person.full_name}\"}"
    end
  end

end
