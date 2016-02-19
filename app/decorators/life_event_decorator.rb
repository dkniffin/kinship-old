class LifeEventDecorator < Draper::Decorator
  delegate_all

  def date_string
    object.date.try(:formatted) || 'Unknown date'
  end

  def details_html
    details_hash.map do |k, v|
      if v.is_a? Array
        singular_key = k.to_s.singularize
        v.map { |elem| key_valueize(singular_key, elem) }.join('<br />')
      else
        key_valueize(k, v)
      end
    end.
      join('<br />').html_safe
  end

  def details_hash
    { date: date_string }.merge(additional_details).merge({ sources: object.sources.map(&:title) })
  end

  # To be over-written by descendants

  def title_string
    'Event'
  end

  def additional_details
    { }
  end

  def icon_class
    'icon-circle'
  end

  def short_description
    'An event'
  end

  private

  def key_valueize(k, v)
    k_string = k.to_s.split('_').map(&:capitalize).join(' ')
    "#{k_string}: #{v}"
  end
end
