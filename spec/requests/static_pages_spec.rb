require 'spec_helper'

describe "Static Pages" do
  describe "Home Page" do
    it "should have a blurb box" do
      visit '/static_pages/home'
      expect(page).to have_selector('div#blurb')
    end
  end
end
