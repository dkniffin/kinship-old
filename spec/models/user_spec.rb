require 'spec_helper'

describe User do
	before { @user = User.new(username: "jschmoe", email: "jschmoe@example.com",
							  password: "foobar", password_confirmation: "foobar") }

	subject { @user }
	it { is_expected.to respond_to(:username) }
	it { is_expected.to respond_to(:email) }
	it { is_expected.to respond_to(:password_digest) }
	it { is_expected.to respond_to(:password) }
	it { is_expected.to respond_to(:password_confirmation) }
	it { is_expected.to respond_to(:role) }
	it { is_expected.to respond_to(:remember_token) }
	it { is_expected.to respond_to(:authenticate) }


	it { is_expected.to be_valid }

	describe "when username is not present" do
		before { @user.username = " " }
		it { is_expected.to be_invalid }
	end

	describe "when email is not present" do
		before { @user.email = " " }
		it { is_expected.to be_invalid }
	end
	describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo.
			             foo@bar_baz.com foo@bar+baz.com]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				expect(@user).to be_invalid
			end
		end
	end

	describe "when email format is valid" do
		it "should be valid" do
			addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			addresses.each do |valid_address|
				@user.email = valid_address
				expect(@user).to be_valid
			end
		end
	end

	describe "when username is already taken" do
		before do
			user_with_same_username = @user.dup
			user_with_same_username.email = @user.email.upcase
			user_with_same_username.save
		end

		it { is_expected.to be_invalid }
	end

	describe "when password is not present" do
		before do
			@user = User.new(username: "Example User", email: "user@example.com",
							 password: " ", password_confirmation: " ")
		end
		it { is_expected.to be_invalid }
	end

	describe "when password doesn't match confirmation" do
		before { @user.password_confirmation = "mismatch" }
		it { is_expected.to be_invalid }
	end

	describe "return value of authenticate method" do
		before { @user.save }
		let(:found_user) { User.find_by(email: @user.email) }

		describe "with valid password" do
			it { is_expected.to eq(found_user.authenticate(@user.password)) }
		end

		describe "with invalid password" do
			let(:user_for_invalid_password) { found_user.authenticate("invalid") }

			it { is_expected.to_not eq(user_for_invalid_password) }
			specify { expect(user_for_invalid_password).to be_falsey }
		end
	end

	describe "with a password that's too short" do
		before { @user.password = @user.password_confirmation = "a" * 5 }
		it { is_expected.to be_invalid }
	end

	describe "when role is not valid" do
		before { @user.role = "blah"}
		it { is_expected.to be_invalid }
	end

	describe "remember token" do
		before { @user.save }
		specify { expect(@user[:remember_token]).to_not be_blank }
	end
end
