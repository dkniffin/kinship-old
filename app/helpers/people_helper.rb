module PeopleHelper
	def setup_person(person)
		person.birth ||= Birth.new
    person.death ||= Death.new
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

  def get_json_pedigree_tree(person)
    if person.birth.date
      birthday = person.birth.date.strftime("%-Y")
    else
      birthday = "?"
    end
    if person.death.date
      deathday = person.death.date.strftime("%-Y")
    else
      deathday = "?"
    end
    json_pedigree_tree = { :name => person.full_name, :born => birthday, :died => deathday, :location => person.birth.place.city, :parents => []}
    father = person.birth.father
    mother = person.birth.mother
    if father && !mother
      json_pedigree_tree[:parents] << get_json_pedigree_tree(father)
      json_pedigree_tree[:parents] << { :name => "Unknown", :born => "?", :died => "?" }
    end
    if mother && !father
      json_pedigree_tree[:parents] << get_json_pedigree_tree(mother)
      json_pedigree_tree[:parents] << { :name => "Unknown", :born => "?", :died => "?" }
    elsif father && mother
      json_pedigree_tree[:parents] << get_json_pedigree_tree(father)
      json_pedigree_tree[:parents] << get_json_pedigree_tree(mother)
    end
    return json_pedigree_tree
  end


end
