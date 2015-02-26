require 'spec_helper'

describe Person do
	before { @person = Person.create }

	subject { @person }

	it { is_expected.to respond_to(:first_name)}
	it { is_expected.to respond_to(:last_name)}
	it { is_expected.to respond_to(:gender)}
	it { is_expected.to respond_to(:photo)}
	it { is_expected.to respond_to(:life_events)}
	it { is_expected.to respond_to(:birth)}
	it { is_expected.to respond_to(:death)}
	it { is_expected.to respond_to(:age)}
	it { is_expected.to respond_to(:full_name)}
	it { is_expected.to respond_to(:father)}
	it { is_expected.to respond_to(:mother)}
	it { is_expected.to respond_to(:children)}
	it { is_expected.to respond_to(:user)}

	describe :gender do
		context "when blank" do
			before { @person.gender = "" }
			it { is_expected.to be_valid }
		end
		context "when male" do
			before { @person.gender = "M" }
			it { is_expected.to be_valid }
		end
		context "when female" do
			before { @person.gender = "F" }
			it { is_expected.to be_valid }
		end

		context "when gender is not M,F,<blank>" do
			before { @person.gender = "X" }
			it { is_expected.to be_invalid }
		end
	end

	describe :mother do
		let(:mom) { Person.create }
		before { @person.mother = mom }

		it "is mom" do
			expect(@person.mother).to be(mom)
		end
		it "is the birth mother" do
			expect(@person.mother).to be(@person.birth.mother)
		end
	end

	describe :father do
		let(:dad) { Person.create }
		before { @person.father = dad }

		it "is dad" do
			expect(@person.father).to be(dad)
		end
		it "is the birth father" do
			expect(@person.father).to be(@person.birth.father)
		end
	end

	describe :age do
		context "when birth date is not given" do
			before do
				@person.birth.date = nil
			end

			specify { expect(@person.age).to be_nil }
		end
		context "when birth is given" do
			let(:bdate) { Date.new(1990,01,01) }
			before(:each) do
				@person.birth.date = bdate
			end

			context "when death is not given" do
				before do
					@person.death.date = nil
				end

				specify "is age today" do
					expect(@person.age).to eq(Date.today.year - bdate.year)
				end
			end
			context "when death is given" do
				let(:ddate) { Date.new(1991,01,02) }
				before do
					@person.death.date = ddate
				end
				specify "is age at death" do
					expect(@person.age).to eq(1)
				end
			end
		end
	end
end
