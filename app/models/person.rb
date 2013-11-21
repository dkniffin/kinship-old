class Person < ActiveRecord::Base
	has_attached_file :photo, :styles => { :small => "256x256>" },
		:default_url => "/assets/default_avatar.png",
		:url  => "/assets/products/:id/:style/:basename.:extension",
		:path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"

	has_one :birth, :foreign_key => "child_id"
	accepts_nested_attributes_for :birth

	validates_attachment_size :photo, :less_than => 5.megabytes
	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

	# We shouldn't validate these, because we might want to add a person where
	# this information is unknown.  
	# For example, what if we want to add a father, because we know he was
	# born in England, but we don't know his name.
	# Another example: we know someone has a sibling, but we don't know their
	# gender
	#validates :first_name, :presence => true
	#validates :last_name, :presence => true
	#validates :gender, :presence => true
	validates_associated :birth

	def father
		birth.father
	end

	def mother
		birth.mother
	end

	def full_name
		first_name + ' ' + last_name
	end

	def age
		diff = Date.today - birth.date
		age = (diff / 365.25).floor
		age.to_s	
    end

	def self.all_genders
		%w(M F)
	end
end
