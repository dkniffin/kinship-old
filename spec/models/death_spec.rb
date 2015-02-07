require 'spec_helper'

describe Death do
	before { @death = Death.create() }

	subject { @death }

	it { should respond_to(:date)}
	it { should respond_to(:place)}
	it { should respond_to(:person)}
	it { should respond_to(:cause)}
	it { should respond_to(:dead)}

	context "when date is in the future" do
		before { @death.date = Date.tomorrow }

		it "is not valid" do
			is_expected.to be_invalid
		end
	end

	describe "#dead" do
		context "when date is in the past" do
			before do
				@death.date = Date.new(1900,01,01)
				puts @death.dead
			end



			specify "is true" do
				expect(@death.dead).to be_truthy
			end
		end
	end
end
