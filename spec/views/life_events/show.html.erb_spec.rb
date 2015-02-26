require 'rails_helper'

RSpec.describe "life_events/show", type: :view do
  before(:each) do
    @life_event = assign(:life_event, LifeEvent.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
