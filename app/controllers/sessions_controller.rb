class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by(username: params[:session][:username].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			if user.person_id.nil?
				redirect_to people_path
			else
				person = Person.find(user.person_id)
				redirect_to person
			end
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
end
