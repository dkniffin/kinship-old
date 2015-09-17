require 'spec_helper'

describe Person do
  subject(:person) { build(:person) }

  it { is_expected.to respond_to(:first_name)}
  it { is_expected.to respond_to(:last_name)}
  it { is_expected.to respond_to(:gender)}

  it { is_expected.to respond_to(:photo)}

  it { is_expected.to respond_to(:birth)}
  it { is_expected.to respond_to(:death)}

  it { is_expected.to respond_to(:father)}
  it { is_expected.to respond_to(:mother)}
  it { is_expected.to respond_to(:parents)}
  it { is_expected.to respond_to(:children)}

  it { is_expected.to respond_to(:age)}
  it { is_expected.to respond_to(:full_name)}

  it { is_expected.to respond_to(:user)}

  describe "#gender" do
    context "when male" do
      subject(:person) { build(:person, gender: "M")}
      it { is_expected.to be_valid }
    end
    context "when female" do
      subject(:person) { build(:person, gender: "F")}
      it { is_expected.to be_valid }
    end
    context "when nil" do
      subject(:person) { build(:person, gender: nil)}
      it { is_expected.to be_valid }
    end

    context "when not M,F,nil" do
      subject(:person) { build(:person, gender: "X")}
      it { is_expected.to be_invalid }
    end
  end

  describe "#parents" do
    let(:mom) { build(:person, gender: 'F') }
    let(:dad) { build(:person, gender: 'M') }
    context "with a mother and a father" do
      before do
        person.update(birth_attributes: {parent_1: mom, parent_2: dad})
      end

      it { is_expected.to be_valid }

      it "has both parents" do
        expect(person.parents).to include(mom)
        expect(person.parents).to include(dad)
      end
    end
  end
  describe "#children" do
    let(:parent) { build(:person) }
    let(:child1) { build(:person) }
    let(:child2) { build(:person) }
    context "with two children" do
      before do
        child1.update(birth_attributes: {parent_1: parent})
        child2.update(birth_attributes: {parent_2: parent})
      end

      it "returns both children" do
        expect(parent.children).to include(child1)
        expect(parent.children).to include(child2)
      end
    end
  end
end
