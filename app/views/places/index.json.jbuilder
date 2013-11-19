json.array!(@places) do |place|
  json.extract! place, :country, :state, :county, :postal_code, :city, :street_address
  json.url place_url(place, format: :json)
end
