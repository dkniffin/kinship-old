require 'spec_helper'

RSpec.describe Reference, type: :model do
  subject { create(:reference) }

  it { is_expected.to respond_to(:source) }
  it { is_expected.to respond_to(:referenceable) }

  it { is_expected.to be_valid }
end
