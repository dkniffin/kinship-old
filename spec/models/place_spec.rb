require 'spec_helper'

describe Place do
  subject(:place) { create(:place) }

  it { is_expected.to respond_to(:street_address) }
  it { is_expected.to respond_to(:city) }
  it { is_expected.to respond_to(:county) }
  it { is_expected.to respond_to(:state) }
  it { is_expected.to respond_to(:postal_code) }
  it { is_expected.to respond_to(:country) }
  it { is_expected.to respond_to(:lat) }
  it { is_expected.to respond_to(:lon) }

  it { is_expected.to be_valid }

  describe '#string' do
    context 'with all place parts' do
      it 'is has the street address' do
        expect(place.to_s).to match(/#{place.street_address}/)
      end
      it 'is has the city' do
        expect(place.to_s).to match(/#{place.city}/)
      end
      it 'is has the county' do
        expect(place.to_s).to match(/#{place.county}/)
      end
      it 'is has the state' do
        expect(place.to_s).to match(/#{place.state}/)
      end
      it 'is has the postal code' do
        expect(place.to_s).to match(/#{place.postal_code}/)
      end
      it 'is has the country' do
        expect(place.to_s).to match(/#{place.country}/)
      end
    end
    context 'with county missing' do
      subject(:place) { create(:place, county: nil) }
      it 'does not have two commas next to each other' do
        expect(place.to_s).to_not match(/,,/)
      end
    end
  end
end
