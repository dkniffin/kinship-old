class Person < ActiveRecord::Base
	has_attached_file :photo, :styles => { :small => "256x256>" },
		:default_url => "/assets/default_avatar.png",
		:url  => "/assets/products/:id/:style/:basename.:extension",
		:path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"

	validates_attachment_size :photo, :less_than => 5.megabytes
	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
	validates :first_name, :presence => true
	validates :last_name, :presence => true
	validates :gender, :presence => true

	def self.all_genders
		%w(M F)
	end
        
end
