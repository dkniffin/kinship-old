class Place < ActiveRecord::Base
	before_validation :default_values

	geocoded_by :full_address, :latitude  => :lat, :longitude => :lon
	after_validation :geocode


	def full_address
		self.street_address + ', '
		self.city + ', '
		self.postal_code + ', '
		self.county + ', '
		self.state + ', '
		self.country
	end

	private
		def default_values
			self.street_address ||= ''
			self.city 			||= ''
			self.postal_code 	||= ''
			self.county 		||= ''
			self.state 			||= ''
			self.country 		||= ''
		end

end
