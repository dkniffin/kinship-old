class Place < ActiveRecord::Base
	before_validation :default_values

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
