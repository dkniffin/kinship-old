require 'rails_helper'

RSpec.describe "life_events/new", type: :view do
  before(:each) do
    assign(:life_event, LifeEvent.new())
  end

  it "renders new life_event form" do
    render

    assert_select "form[action=?][method=?]", life_events_path, "post" do
    end
  end
end
