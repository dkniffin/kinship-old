require 'spec_helper'

describe Death do
  before { @death = Death.create() }

  subject { @death }

  it { is_expected.to respond_to(:date)}
  it { is_expected.to respond_to(:place)}
  it { is_expected.to respond_to(:person)}
  it { is_expected.to respond_to(:cause)}
  it { is_expected.to respond_to(:dead)}

  context "when date is in the future" do
    before { @death.date = Date.tomorrow }

    it { is_expected.to be_invalid }
  end

  describe "#dead" do
    context "when date is in the past" do
      before do
        @death.date = Date.new(1900,01,01)
      end

      specify "is true" do
        expect(@death.dead).to be_truthy
      end
    end
  end
end
