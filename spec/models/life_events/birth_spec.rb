require 'spec_helper'

describe Birth do
  subject(:birth) { build(:birth) }

  it { is_expected.to respond_to(:child)}
  it { is_expected.to respond_to(:parent_1)}
  it { is_expected.to respond_to(:parent_2)}
  it { is_expected.to respond_to(:mother)}
  it { is_expected.to respond_to(:father)}
  it { is_expected.to respond_to(:parents)}

  describe "#parents" do
    let(:mom) { build(:person, gender: 'F') }
    let(:mom2) { build(:person, gender: 'F') }
    let(:dad) { build(:person, gender: 'M') }
    let(:dad2) { build(:person, gender: 'M') }
    context "with a mother and a father" do
      before do
        birth.update(parent_1: mom, parent_2: dad)
      end

      it { is_expected.to be_valid }

      it "has both parents" do
        expect(birth.parents).to include(mom)
        expect(birth.parents).to include(dad)
      end
    end
    context "with only a mother" do
      before do
        birth.update(parent_1: mom)
      end

      it { is_expected.to be_valid }

      it "has the mother" do
        expect(birth.parents).to include(mom)
      end
    end
    context "with only a father" do
      before do
        birth.update(parent_1: dad)
      end

      it { is_expected.to be_valid }

      it "has the father" do
        expect(birth.parents).to include(dad)
      end
    end
    context "with two fathers" do
      before do
        birth.update(parent_1: dad, parent_2: dad2)
      end

      it { is_expected.to be_valid }

      it "has both fathers" do
        expect(birth.parents).to include(dad)
        expect(birth.parents).to include(dad)
      end
    end
    context "with two mothers" do
      before do
        birth.update(parent_1: mom, parent_2: mom2)
      end

      it { is_expected.to be_valid }

      it "has both mothers" do
        expect(birth.parents).to include(mom)
        expect(birth.parents).to include(mom)
      end
    end
  end
end
