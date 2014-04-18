require 'spec_helper'

describe "places/show" do
  before(:each) do
    @place = assign(:place, stub_model(Place,
      :country => "Country",
      :state => "State",
      :county => "County",
      :postal_code => "Postal Code",
      :city => "City",
      :street_address => "Street Address"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Country/)
    rendered.should match(/State/)
    rendered.should match(/County/)
    rendered.should match(/Postal Code/)
    rendered.should match(/City/)
    rendered.should match(/Street Address/)
  end
end
