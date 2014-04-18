class AdminController < ApplicationController
	before_action :authorization
	def home
	end
	
	def look_and_feel
		@blurb = Setting.homepage_blurb
		@eventsFormat = Setting.eventsFormat
		@site_header = Setting.site_header
	end
	def update_look_and_feel
		# Permitted params
		params.permit(:blurb, :eventsFormat, :site_header)

		# Update the settings
		Setting.homepage_blurb = params[:blurb]
		Setting.eventsFormat = params[:eventsFormat]
		Setting.site_header = params[:site_header]

		# Flash a success message and send back to page
		flash[:success] = params
		redirect_to :back
	end

	def privacy
	end

	def users
	end

	def logs
	end

	private
		def authorization
			redirect_to root_url, 
				notice: "Only admins can access the admin interface" unless user_role?(User::ROLE_ADMIN)
		end
end
