module SessionsHelper
	def sign_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = user
	end
	
	def signed_in?
		!current_user.nil?
	end

	def user_role?(role)
		if signed_in? && role_rank(current_user.role) >= role_rank(role)
			return true
		end
		return false
	end

	def role_rank(role)
		case role
		when User::ROLE_UNAPPROVED
			return 0 
		when User::ROLE_MEMBER
			return 1
		when User::ROLE_EDITOR
			return 2
		when User::ROLE_ADMIN
			return 3
		end	
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end

	def current_user?(user)
		user == current_user
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end
end