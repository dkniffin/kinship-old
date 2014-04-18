require 'spec_helper'

describe Person do
	before { @person = Person.create() }

	subject { @person }

	it { should respond_to(:first_name)}
	it { should respond_to(:last_name)}
	it { should respond_to(:gender)}
	it { should respond_to(:photo)}
	it { should respond_to(:birth)}
	it { should respond_to(:age)}
	it { should respond_to(:full_name)}
	it { should respond_to(:father)}
	it { should respond_to(:mother)}

	describe "when gender is blank" do
		before { @person.gender = "" }
		it { should be_valid }
	end

	describe "when gender is invalid" do
		before { @person.gender = "X" }
		it { should_not be_valid }
	end

	describe "when there is an associated mother"	do
		before do
			@mom = Person.create()
			@person.update_attributes({:birth_attributes => {:mother_id => @mom.id }})
		end

		specify { @person.mother.should eq(@mom) }
	end
	describe "when there is not an associated mother" do
		before do
			@mom = Person.create()
		end

		specify { @person.mother.should_not eq(@mom) }
	end

	describe "when there is an associated father" do
		before do
			@dad = Person.create()
			@person.update_attributes({:birth_attributes => {:father_id => @dad.id }})
		end

		specify { @person.father.should eq(@dad) }
	end
	describe "when there is not an associated father" do
		before do
			@dad = Person.create()
		end

		specify { @person.father.should_not eq(@dad) }
	end

	describe "when no birth date is specified" do
		before do
			@person.update_attributes({:birth_attributes => { :date => nil }})
		end

		specify { @person.age.should be_nil }
	end

end
