require 'spec_helper'

describe "people/show" do
  let(:person) { FactoryGirl.create(:person) }
  before(:each) do
    @person = person
  end

  it "renders properly" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should have_selector('img#photo')
    rendered.should have_selector('#full_name')
    rendered.should have_content('Gender')
    rendered.should have_content('Birth date')
    rendered.should have_link('Edit', :href => edit_person_path(@person))
  end
end
