class Person < ActiveRecord::Base
	before_validation :default_values
	before_create :build_default_birth

	# Photo stuff
	has_attached_file :photo, :styles => { :small => "256x256>" },
		:default_url => "/assets/default_avatar.png",
		:url  => "/assets/products/:id/:style/:basename.:extension",
		:path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"
	validates_attachment_size :photo, :less_than => 5.megabytes
	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

	has_one :birth, :foreign_key => "child_id"
	accepts_nested_attributes_for :birth

	# Aloow blank values; see private method default_values for details
	validates :first_name, :presence => true, :allow_blank => true
	validates :last_name, :presence => true, :allow_blank => true
	validates :gender, :presence => true, :allow_blank => true
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
		return nil if birth.date.nil?


		diff = Date.today - birth.date
		age = (diff / 365.25).floor
		age.to_s	
    end

	def self.all_genders
		%w(M F)
	end

	private
		def default_values
			# These values might not be known when we build the user, but we
			# still want them to have a value, so we'll set them to blank

			# Some examples where we might not know this information:
			#  We want to add a father, because we know where he was born, but
			#  we don't know his name.
			#  We know someone has a sibling, but we don't know their gender

			self.first_name ||= ''
			self.last_name ||= ''
			self.gender ||= ''
		end
		def build_default_birth
			build_birth if birth.nil? 
		end
end
