require 'spec_helper'

describe "places/new" do
  before(:each) do
    assign(:place, stub_model(Place,
      :country => "MyString",
      :state => "MyString",
      :county => "MyString",
      :postal_code => "MyString",
      :city => "MyString",
      :street_address => "MyString"
    ).as_new_record)
  end

  it "renders new place form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", places_path, "post" do
      assert_select "input#place_country[name=?]", "place[country]"
      assert_select "input#place_state[name=?]", "place[state]"
      assert_select "input#place_county[name=?]", "place[county]"
      assert_select "input#place_postal_code[name=?]", "place[postal_code]"
      assert_select "input#place_city[name=?]", "place[city]"
      assert_select "input#place_street_address[name=?]", "place[street_address]"
    end
  end
end
