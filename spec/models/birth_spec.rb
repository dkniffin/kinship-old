require 'spec_helper'

describe Birth do
  subject(:birth) { Birth.new }

	it { is_expected.to respond_to(:date)}
	it { is_expected.to respond_to(:child)}
	it { is_expected.to respond_to(:place)}
	it { is_expected.to respond_to(:child_id)}
	it { is_expected.to respond_to(:mother_id)}
	it { is_expected.to respond_to(:father_id)}

  describe "valid birth" do
  	subject(:birth) { build(:birth) }

    describe :mother do
  		context "when mother is defined" do
  			let(:mom) { create(:person) }
  			before { birth.mother_id = mom.id }

  			it "has the mother" do
  				expect(birth.mother).to eq(mom)
  			end
  		end
  		context "when father is defined" do
  			let(:dad) { create(:person) }
  			before { birth.father_id = dad.id }

  			it "has the father" do
  				expect(birth.father).to eq(dad)
  			end
  		end

  	end
  end

  describe "invalid birth" do
  	context "when date is in the future" do
  		before { birth.date = Date.tomorrow }

  		it "is not valid" do
  			is_expected.to be_invalid
  		end
  	end
  end

end
