class Death < ActiveRecord::Base
	before_save :build_default_place

	before_validation :dead_if_date

	validates :dead, inclusion: { in: [true] }, if: "!date.nil?"

	belongs_to :person
	belongs_to :place, :autosave => true


	private
		def dead_if_date
			if !date.nil?
				dead = true
			end
		end
		def build_default_place
			build_place if place.nil? 
		end
end
