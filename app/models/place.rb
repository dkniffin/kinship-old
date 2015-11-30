class Place < ActiveRecord::Base
  before_validation :default_values, :cleanup_input

  geocoded_by :string, latitude: :lat, longitude: :lon
  after_validation :geocode

  before_create :default_values

  belongs_to :locatables, polymorphic: true

  def has_valid_latlng?
    # TODO: Add a check to see if it is actually valid (real coords)
    if lat.nil? || lon.nil?
      false
    else
      true
    end
  end


  def full_address_and_id
    to_s + " \(#{id}\)"
  end

  def string
    s = "#{street_address}, #{city}, #{county}, #{state} #{postal_code} #{country}"
    s.gsub(/( ,)+|^,/, "")
  end

  def string=(input = "")
    retVal = Geocoder.search(input).first

    if !retVal.nil?
      self.country = (retVal.country.nil?) ? '' : retVal.country.to_s
      self.state = (retVal.state.nil?) ? '' : retVal.state.to_s
      self.county = (retVal.county.nil?) ? '' : retVal.county.to_s
      self.postal_code = (retVal.postal_code.nil?) ? '' : retVal.postal_code.to_s
      self.city = (retVal.city.nil?) ? '' : retVal.city.to_s

      hn = (retVal.house_number.nil?) ? '' : retVal.house_number.to_s
      st = (retVal.street.nil?) ? '' : retVal.street.to_s
      self.street_address = hn + ' ' + st

    #geocode
    else
      splt = input.split(/,\s*/).reverse

      self.country = (splt[0].nil?) ? '' : splt[0]
      self.state = (splt[1].nil?) ? '' : splt[1]
      self.county = (splt[2].nil?) ? '' : splt[2]
      self.postal_code = (splt[3].nil?) ? '' : splt[3]
      self.city = (splt[4].nil?) ? '' : splt[4]
      self.street_address = (splt[5].nil?) ? '' : splt[5]
    end

    self.save
  end

  def empty?
    to_s.rstrip.empty?
  end

  private
    def default_values
      self.street_address ||= ''
      self.city           ||= ''
      self.postal_code    ||= ''
      self.county         ||= ''
      self.state          ||= ''
      self.country        ||= ''
    end

    def cleanup_input
      self.street_address = clean_field(self.street_address)
      self.city = clean_field(self.city)
      self.postal_code = clean_field(self.postal_code)
      self.county = clean_field(self.county)
      self.state = clean_field(self.state)
    self.country = clean_field(self.country)
    end

    def clean_field(field)
      # Removed spaces and commas at the beginning and the end
      field.gsub(/^\s+|\s+$|^,|,$/, "")
    end
end
