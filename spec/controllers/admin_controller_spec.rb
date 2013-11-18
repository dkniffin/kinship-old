require 'spec_helper'

describe AdminController do

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'look_and_feel'" do
    it "returns http success" do
      get 'look_and_feel'
      response.should be_success
    end
  end

  describe "GET 'privacy'" do
    it "returns http success" do
      get 'privacy'
      response.should be_success
    end
  end

  describe "GET 'users'" do
    it "returns http success" do
      get 'users'
      response.should be_success
    end
  end

  describe "GET 'logs'" do
    it "returns http success" do
      get 'logs'
      response.should be_success
    end
  end

end
