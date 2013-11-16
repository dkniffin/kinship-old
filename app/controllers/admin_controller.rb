class AdminController < ApplicationController
	before_action :admin_user
	def home
	end
	
	def look_and_feel
	end

	def privacy
	end

	def users
	end

	def logs
	end

	private
		def admin_user
			redirect_to root_url, 
				notice: "Only admins can access the admin interface" unless user_role?(User::ROLE_ADMIN)
		end
end
