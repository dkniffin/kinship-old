class LifeEvent::MarriageDecorator < LifeEventDecorator
  def title_string
    'Marriage'
  end

  def details_hash
    {
      spouse_1: object.person_1.full_name,
      spouse_2: object.person_2.full_name,
      date: date_string,
      place: place.string
    }
  end

  def icon_class
    'icon-rings'
  end

  def short_description
    "#{object.person_1.full_name} married #{object.person_2.full_name}"
  end

  def event_name
    "The marriage between #{person_1.full_name} and #{person_2.full_name}"
  end
end
