class User < ActiveRecord::Base
	validates :username, presence: true
	VALID_EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.\-]+\.[A-Z]{2,4}\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
		uniquness: { case_sensitive: false }
end
