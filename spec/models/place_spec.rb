require 'spec_helper'

describe Place do
	before { @place = Place.create() }

	subject { @place }

	it { should respond_to(:street_address)}
	it { should respond_to(:city)}
	it { should respond_to(:postal_code)}
	it { should respond_to(:county)}
	it { should respond_to(:state)}
	it { should respond_to(:country)}
	it { should respond_to(:lat)}
	it { should respond_to(:lon)}
	it { should respond_to(:place_string)}
end
