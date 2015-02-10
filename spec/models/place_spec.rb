require 'spec_helper'

describe Place do
	before { @place = Place.create() }

	subject { @place }

	it { is_expected.to respond_to(:street_address)}
	it { is_expected.to respond_to(:city)}
	it { is_expected.to respond_to(:postal_code)}
	it { is_expected.to respond_to(:county)}
	it { is_expected.to respond_to(:state)}
	it { is_expected.to respond_to(:country)}
	it { is_expected.to respond_to(:lat)}
	it { is_expected.to respond_to(:lon)}
	it { is_expected.to respond_to(:place_string)}

	describe "place parts" do
		let(:place_parts) { [:country,:state,:county,:postal_code,:city,:street_address] }
		specify "are all strings" do
			for part in place_parts do
				expect(@place[part]).to be_a(String)
			end
		end
	end
end
