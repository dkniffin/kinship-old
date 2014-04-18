require 'spec_helper'

describe "people/show" do
  let(:person) { FactoryGirl.create(:person) }
  before(:each) do
    @person = person
  end
end
