module PeopleHelper
  def setup_person(person)
    person.birth ||= LifeEvent::Birth.new
    person.death ||= LifeEvent::Death.new
    person
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
    json_pedigree_tree = {
      name: person.full_name,
      born: birthday,
      died: deathday,
      location: person.birth.place.city,
      parents: []
    }
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

  def markers_for_map(markers)
    markers.map do |marker|
      {
        :latlng => marker[:latlng],
        :popup => '<h3 class="popup-header">' + h(marker[:title]) + '</h3><br/>' +
                  h(marker[:place]) + '<br/>' +
                  h(marker[:date])
      }
    end
  end

  def parent_title(gender)
    if gender == Person::MALE
      'Father'
    elsif gender == Person::FEMALE
      'Mother'
    else
      'Parent'
    end
  end
end
