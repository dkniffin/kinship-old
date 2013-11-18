class AdminController < ApplicationController
	before_action :admin_user
	def home
	end
	
	def look_and_feel
		@blurb = Setting.homepage_blurb
		@eventsFormat = Setting.eventsFormat
	end
	def update_look_and_feel
		# Permitted params
		params.permit(:blurb, :eventsFormat)

		# Update the settings
		Setting.homepage_blurb = params[:blurb]
		Setting.eventsFormat = params[:eventsFormat]

		# Flash a success message and send back to page
		flash[:success] = "Settings updated"
		redirect_to :back
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
