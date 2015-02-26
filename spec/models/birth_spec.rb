require 'spec_helper'

describe Birth do
 	before { @birth = Birth.create() }

	subject { @birth }

	it { is_expected.to respond_to(:date)}
	it { is_expected.to respond_to(:person)}
	it { is_expected.to respond_to(:place)}
	it { is_expected.to respond_to(:child_id)}
	it { is_expected.to respond_to(:mother_id)}
	it { is_expected.to respond_to(:father_id)}

	context "when date is in the future" do
		before { @birth.date = Date.tomorrow }

		it "is not valid" do
			is_expected.to be_invalid
		end
	end

	describe :mother do
		context "when defined" do
			let(:mom) { Person.create }
			before { @birth.mother = mom }

			it "is defined" do
				expect(@birth.mother).to be(mom)
			end
		end
		context "when not defined" do
			specify "is nil" do
				expect(@birth.mother).to be_nil
			end
		end
	end

	describe :father do
		context "when defined" do
			let(:dad) { Person.create() }
			before { @birth.father = dad }

			it "is defined" do
				expect(@birth.father).to eq(dad)
			end
		end
		context "when not defined" do
			specify "is nil" do
				expect(@birth.father).to be_nil
			end
		end
	end
end
