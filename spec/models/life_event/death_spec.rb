require 'spec_helper'

describe LifeEvent::Death, type: :model do
  subject(:death) { build(:death) }

  it { is_expected.to respond_to(:date) }
  it { is_expected.to respond_to(:place) }
  it { is_expected.to respond_to(:person) }
  it { is_expected.to respond_to(:cause) }

  it { is_expected.to respond_to(:references) }
  it { is_expected.to respond_to(:sources) }

  context "when date is in the future" do
    before { death.date = Date.tomorrow }

    it { is_expected.to be_invalid }
  end
end
