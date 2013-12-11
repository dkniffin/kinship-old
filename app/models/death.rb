class Death < ActiveRecord::Base
	before_save :build_default_place

	before_validation :dead_if_date

	validates :dead, inclusion: { in: [true] }, if: "!date.nil?"

	belongs_to :person
	belongs_to :place, :autosave => true
	accepts_nested_attributes_for :place
	validates_associated :place

	def short_description
		if self.cause
			person.full_name + ' died' + " (cause: #{self.cause})"
		else
			person.full_name + ' died'
		end
	end

	def icon_class
		'icon-cemetery'
	end

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
