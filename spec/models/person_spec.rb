require 'spec_helper'

describe Person do
	before { @person = Person.create() }

	subject { @person }

	it { is_expected.to respond_to(:first_name)}
	it { is_expected.to respond_to(:last_name)}
	it { is_expected.to respond_to(:gender)}
	it { is_expected.to respond_to(:photo)}
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
		context "when a person is associated as mother" do
			let(:mom) { Person.create() }
			before do
				@person.update_attributes({
					:birth_attributes => {
						:mother_id => mom.id
					}
				})
			end

			it "has the mother" do
				expect(@person.mother).to eq(mom)
			end
		end
		context "when there is no associated mother" do
			specify "mother is nil" do
				expect(@person.mother).to be_nil
			end
		end
	end

	describe :father do
		context "when a person is associated as father" do
			let(:dad) { Person.create() }
			before do
				@person.update_attributes({
					:birth_attributes => {
						:father_id => dad.id
					}
				})
			end

			it "has that father" do
				expect(@person.father).to eq(dad)
			end
		end
		context "when there is no associated father" do
			specify "father is nil" do
				expect(@person.father).to be_nil
			end
		end
	end

	describe :age do
		context "when birth is not given" do
			before do
				@person.update_attributes({:birth_attributes => { :date => nil }})
			end

			specify { expect(@person.age).to be_nil }
		end
		context "when birth is given" do
			let(:bdate) { Date.new(1990,01,01) }
			before(:each) do
				@person.update_attributes({:birth_attributes => { :date => bdate }})
			end

			context "when death is not given" do
				before do
					@person.update_attributes({:death_attributes => { :date => nil }})
				end

				specify "is age today" do
					expect(@person.age).to eq(Date.today.year - bdate.year)
				end
			end
			context "when death is given" do
				let(:ddate) { Date.new(1991,01,02) }
				before do
					@person.update_attributes({:death_attributes => { :date => ddate }})
				end
				specify "is age at death" do
					expect(@person.age).to eq(1)
				end
			end
		end
	end
end
