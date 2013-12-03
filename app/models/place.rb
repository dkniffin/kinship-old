class Place < ActiveRecord::Base
	before_validation :default_values

	belongs_to :birth

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
	def full_address_and_id
		full_address + " \(#{id}\)"
	end

	private
		def default_values
			self.street_address ||= ''
			self.city 			||= ''
			self.postal_code 	||= ''
			self.county 		||= ''
			self.state 			||= ''
			self.country 		||= ''
			self.lat 			||= 37.09024
			self.lon 			||= -95.712891

		end

end
