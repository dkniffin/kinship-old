class Place < ActiveRecord::Base
	before_validation :default_values

	geocoded_by :full_address, :latitude  => :lat, :longitude => :lon
	after_validation :geocode

	before_create :default_values

	has_many :births
	has_many :deaths


	def full_address
		[self.street_address, self.city, self.postal_code, 
			self.county, self.state, self.country].join(', ')
	end
	def full_address_and_id
		full_address + " \(#{id}\)"
	end

	# May want to rename this...
	def place_string
		return full_address
	end
	def place_string=(input="")
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

	private
		def default_values
			self.street_address ||= ''
			self.city 			||= ''
			self.postal_code 	||= ''
			self.county 		||= ''
			self.state 			||= ''
			self.country 		||= 'United States of America'
			#self.lat 			||= 37.09024
			#self.lon 			||= -95.712891
		end

end
