class LifeEvent::DeathDecorator < LifeEventDecorator
  def title_string
    'Death'
  end

  def short_description
    "#{person.full_name} died#{cause_or_empty_string}"
  end

  def icon_class
    'icon-cemetery'
  end

  def additional_details
    {
      cause: cause_string
    }
  end

  def cause_string
    cause || 'Unknown cause'
  end

  private

  def cause_or_empty_string
    if object.cause.present?
      "(cause: #{cause_string})"
    else
      ''
    end
  end
end
