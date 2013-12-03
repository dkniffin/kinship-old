class Death < ActiveRecord::Base
	belongs_to :person
	before_validation :dead_if_date

	validates :dead, inclusion: { in: [true] }, if: "date.nil?"


	private
		def dead_if_date
			if !date.nil?
				dead = true
			end
		end
end
