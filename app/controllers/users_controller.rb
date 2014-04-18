class UsersController < ApplicationController
	before_action :signed_in_user, only: [:edit, :update]
	before_action :authorization, except: [:new, :create]

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def update_role
		@user = User.find(params[:id])
		if @user.update_attribute(:role, params[:role])
			flash[:success] = "Role Changed"
		else
			flash[:error] = "Error"
		end
		redirect_to :back
	end

	def update_person
		@user = User.find(params[:id])
		if @user.update_attribute(:person_id, params[:person_id])
			flash[:success] = "Person Changed"
		else
			flash[:error] = "Error"
		end
		redirect_to :back
	end

	def create
	    @user = User.new(user_params)
		if @user.save
			flash[:success] = "Your account request has been submitted to the admin(s) for approval."
			redirect_to home_path
		else
			render 'new'
		end
	end

	private

		def user_params
			params.require(:user).permit(:username, :email, :password,
										 :password_confirmation)
		end

		def user_role_param
			params.permit(:role)
		end

		# Before filters

		def signed_in_user
			redirect_to signin_url, notice: "Please sign in." unless signed_in?
		end

		def authorization
			if !(user_role?(User::ROLE_ADMIN) || current_user?(User.find(params[:id])))
				begin
					redirect_to :back, 
						notice: "Only the specified user and admins can access the edit interface for this user" 
				rescue ActionController::RedirectBackError
  					redirect_to root_path
  				end
			end
		end
		
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user?(@user)
		end
end
