require 'spec_helper'

	describe "User pages" do

	subject { page }

	describe "signup page" do
		before { visit signup_path }

		it { should have_content('Request an Account') }
	end
	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before { sign_in user }
		before { visit user_path(user) }

		it { should have_content(user.username) }
	end

	describe "signup" do

		before { visit signup_path }

		let(:submit) { "Create my account" }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "Username",     with: "example"
				fill_in "Email",        with: "user@example.com"
				fill_in "Password",     with: "foobar"
				fill_in "Confirmation", with: "foobar"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end
		end
	end
	describe "edit" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit edit_user_path(user)
		end

		describe "page" do
			it { should have_content("Edit User") }
		end

		describe "with invalid information" do
			before { click_button "Save changes" }

			it { should have_content('error') }
		end

		
	end
end
