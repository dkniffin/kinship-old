require 'spec_helper'

describe "places/index" do
  before(:each) do
    assign(:places, [
      stub_model(Place,
        :country => "Country",
        :state => "State",
        :county => "County",
        :postal_code => "Postal Code",
        :city => "City",
        :street_address => "Street Address"
      ),
      stub_model(Place,
        :country => "Country",
        :state => "State",
        :county => "County",
        :postal_code => "Postal Code",
        :city => "City",
        :street_address => "Street Address"
      )
    ])
  end

  it "renders a list of places" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "County".to_s, :count => 2
    assert_select "tr>td", :text => "Postal Code".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "Street Address".to_s, :count => 2
  end
end
