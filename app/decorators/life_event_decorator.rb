class LifeEventDecorator < Draper::Decorator
  delegate_all

  def date_string
    object.date.try(:formatted) || 'Unknown date'
  end

  def details_html
    details_hash.map do |k,v|
      "#{k.capitalize}: #{v}"
    end.
    join('<br />').html_safe
  end

  # To be over-written by descendants

  def title_string
    'Event'
  end

  def details_hash
    {
      date: date_string
    }
  end

  def icon_class
    'icon-circle'
  end

  def short_description
    'An event'
  end
end
