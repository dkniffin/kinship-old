require 'spec_helper'

RSpec.describe Marriage, type: :model do
  subject(:marriage) { build(:marriage) }

  it { is_expected.to respond_to(:person_1) }
  it { is_expected.to respond_to(:person_2) }
  it { is_expected.to respond_to(:date) }
end
