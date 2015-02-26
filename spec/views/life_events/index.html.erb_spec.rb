require 'rails_helper'

RSpec.describe "life_events/index", type: :view do
  before(:each) do
    assign(:life_events, [
      LifeEvent.create!(),
      LifeEvent.create!()
    ])
  end

  it "renders a list of life_events" do
    render
  end
end
