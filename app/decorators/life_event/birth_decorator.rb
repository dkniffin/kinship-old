class LifeEvent::BirthDecorator < LifeEventDecorator
  def title_string
    'Birth'
  end

  def short_description
    "#{object.child.full_name} was born"
  end

  def additional_details
    {
      parents: parents_string
      # place: place_string
    }
  end

  def icon_class
    'icon-baby'
  end

  private

  def parents_string
    "#{mother_string} and #{father_string}"
  end

  def mother_string
    (object.mother.nil?) ? 'Unknown mother' : object.mother.full_name
  end

  def father_string
    (object.father.nil?) ? 'Unknown father' : object.father.full_name
  end
end
