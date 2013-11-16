class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	before_create :create_remember_token
	before_validation :unapproved

	# Attribute validations
	validates :username, presence: true
	VALID_EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.\-]+\.[A-Z]{2,4}\z/i
	validates :email, presence: true, 
					  format: { with: VALID_EMAIL_REGEX }, 
					  uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, length: { minimum: 6 }
	ROLES = [ROLE_UNAPPROVED = 'unauthorized',
			 ROLE_MEMBER = 'member', # Read-only
			 ROLE_EDITOR = 'editor',
			 ROLE_ADMIN = 'admin']
    validates :role, presence: true, inclusion: {in: ROLES}

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end

		def unapproved
			self.role = User::ROLE_UNAPPROVED if self.role.nil?
		end
end
