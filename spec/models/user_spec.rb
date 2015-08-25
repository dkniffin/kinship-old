require 'spec_helper'

describe User, type: :model do
	subject(:user) { User.new }

	it { is_expected.to respond_to(:email) }
	it { is_expected.to respond_to(:password) }
	it { is_expected.to respond_to(:role) }

  describe "valid user" do
    subject(:user) { build(:user) }

    it "is valid" do
      expect(user).to be_valid
    end
    it "has an email" do
      expect(user.email).to be_a(String)
    end
    it "has a password" do
      expect(user.password).to be_a(String)
    end
  end

  describe "invalid" do
    let(:no_email) { build(:user, email: nil) }
    let(:no_password) { build(:user, password: nil) }
		let(:invalid_role) { build(:user, role: 'blah') }

    it "missing email" do
      expect(no_email).to_not be_valid
      expect(no_email.errors).to include(:email)
      expect(no_email.errors[:email]).to include("can't be blank")
    end
    it "email" do
      expect(build(:user, email: 'user@foo,com')).to_not be_valid
      expect(build(:user, email: 'user_at_foo.org')).to_not be_valid
      expect(build(:user, email: 'example.user@foo.')).to_not be_valid
      expect(build(:user, email: 'foo@bar_baz.com')).to_not be_valid
      expect(build(:user, email: 'foo@bar+baz.com')).to_not be_valid
    end
    it "missing password" do
      expect(no_password).to_not be_valid
      expect(no_password.errors).to include(:password)
      expect(no_password.errors[:password]).to include("can't be blank")
    end

		it "role" do
			expect(invalid_role).to_not be_valid
      expect(no_password.errors).to include(:role)
		end
  end
end
