require 'spec_helper'

	describe "User pages" do

	subject { page }

	describe "signup page" do
		before { visit signup_path }

		it { should have_content('Sign up') }
	end
	
	describe "profile page" do
		# Replace with code to make a user variable
		before { visit user_path(user) }

		it { should have_content(user.name) }
	end
end