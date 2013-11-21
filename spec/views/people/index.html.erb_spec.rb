require 'spec_helper'

describe "people/index" do
  let(:person) { FactoryGirl.create(:person) }
  before(:each) do
    assign(:people, [person, person])
    assign(:all_genders, Person.all_genders)
    assign(:selected_genders, Person.all_genders)
  end

  it "renders a list of people" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>th", :text => "First Name".to_s
    assert_select "tr>th", :text => "Last Name".to_s
    assert_select "tr>th", :text => "Gender".to_s
    assert_select "tr>th", :text => "Photo".to_s
  end
end
