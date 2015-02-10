require 'spec_helper'
require 'pp'

describe AdminController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }

  context "admins" do
    before { sign_in admin, :no_capybara => true }


    it "can access home" do
      get 'home'
      expect(response).to be_success
    end

    it "can access look_and_feel" do
      get 'look_and_feel'
      expect(response).to be_success
    end

    it "can access privacy" do
      get 'privacy'
      expect(response).to be_success
    end

    it "can access users" do
      get 'users'
      expect(response).to be_success
    end

    it "can access logs" do
      get 'logs'
      expect(response).to be_success
    end
  end

  context "non-admins" do
    before { sign_in user, :no_capybara => true }


    it "can't access home" do
      get 'home'
      expect(response).to be_redirect
    end

    it "can't access look_and_feel" do
      get 'look_and_feel'
      expect(response).to be_redirect
    end

    it "can't access privacy" do
      get 'privacy'
      expect(response).to be_redirect
    end

    it "can't access users" do
      get 'users'
      expect(response).to be_redirect
    end

    it "can't access logs" do
      get 'logs'
      expect(response).to be_redirect
    end
  end
end
