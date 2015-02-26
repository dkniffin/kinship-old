require 'rails_helper'

RSpec.describe "life_events/edit", type: :view do
  before(:each) do
    @life_event = assign(:life_event, LifeEvent.create!())
  end

  it "renders the edit life_event form" do
    render

    assert_select "form[action=?][method=?]", life_event_path(@life_event), "post" do
    end
  end
end
