require 'spec_helper'

describe LifeEvent::Marriage, type: :model do
  subject(:marriage) { build(:marriage) }

  it { is_expected.to respond_to(:person_1) }
  it { is_expected.to respond_to(:person_2) }
  it { is_expected.to respond_to(:date) }

  it { is_expected.to respond_to(:references) }
  it { is_expected.to respond_to(:sources) }
end
