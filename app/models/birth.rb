class Birth < ActiveRecord::Base
	belongs_to :child, :class_name => "Person", :foreign_key => "child"

	def father
		if father_id
			Person.find(father_id)
		else
			nil
		end
	end

	def mother
		if mother_id
			Person.find(mother_id)
		else
			nil
		end
	end
end
