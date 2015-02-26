require "rails_helper"

RSpec.describe LifeEventsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/life_events").to route_to("life_events#index")
    end

    it "routes to #new" do
      expect(:get => "/life_events/new").to route_to("life_events#new")
    end

    it "routes to #show" do
      expect(:get => "/life_events/1").to route_to("life_events#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/life_events/1/edit").to route_to("life_events#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/life_events").to route_to("life_events#create")
    end

    it "routes to #update" do
      expect(:put => "/life_events/1").to route_to("life_events#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/life_events/1").to route_to("life_events#destroy", :id => "1")
    end

  end
end
