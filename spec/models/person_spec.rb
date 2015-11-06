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
        subject.update(birth_attributes: {parent_1: mom, parent_2: dad})
      end

      it { is_expected.to be_valid }

      it "has both parents" do
        expect(subject.parents).to include(mom)
        expect(subject.parents).to include(dad)
      end
    end
  end

  describe "#children" do
    let(:child1) { build(:person) }
    let(:child2) { build(:person) }
    context "with two children" do
      before do
        child1.update(birth_attributes: {parent_1: subject})
        child2.update(birth_attributes: {parent_2: subject})
      end

      it "returns both children" do
        expect(subject.children).to include(child1)
        expect(subject.children).to include(child2)
      end
    end
  end

  describe "#marriages" do
    let(:spouse_1) { create(:person) }
    let(:spouse_2) { create(:person) }
    let!(:marriage_1) { create(:marriage, person_1: spouse_1, person_2: subject) }
    let!(:marriage_2) { create(:marriage, person_1: subject, person_2: spouse_2) }

    it "includes all marriages that involve the person" do
      expect(subject.marriages).to include(marriage_1)
      expect(subject.marriages).to include(marriage_2)
    end
  end

  describe "#spouses" do
    let(:spouse_1) { create(:person) }
    let(:spouse_2) { create(:person) }
    let!(:marriage_1) { create(:marriage, person_1: spouse_1, person_2: subject) }
    let!(:marriage_2) { create(:marriage, person_1: subject, person_2: spouse_2) }

    it "includes all spouses of subject" do
      expect(subject.spouses).to include(spouse_1)
      expect(subject.spouses).to include(spouse_2)
    end
  end
end
