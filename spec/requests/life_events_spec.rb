require 'rails_helper'

RSpec.describe "LifeEvents", type: :request do
  describe "GET /life_events" do
    it "works! (now write some real specs)" do
      get life_events_path
      expect(response).to have_http_status(200)
    end
  end
end
