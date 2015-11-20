class PersonDecorator < Draper::Decorator
  delegate_all

  def full_name_and_id
    "#{object.full_name} (#{object.id})"
  end

  def markers
    event_markers = []

    events.each do |event|
    if event.place.has_valid_latlng?
      event_markers.push({
        :latlng => [event.place.lat, event.place.lon],
        :title => event.title_string,
        :place => event.place.place_string,
        :date => event.date_string
      })
      end
    end
    event_markers
  end
end
