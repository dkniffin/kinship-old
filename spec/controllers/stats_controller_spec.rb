require 'spec_helper'

describe StatsController, type: :controller do
  let(:json_response) { JSON.parse(response.body) }

  describe '#gender_distribution' do
    let!(:males) { create_list(:person, 10, gender: Person::MALE) }
    let!(:females) { create_list(:person, 15, gender: Person::FEMALE) }

    subject { get :gender_distribution, format: :json }

    it 'returns a hash mapping gender to count' do
      subject
      expect(json_response).to eq({ 'male' => 10, 'female' => 15})
    end
  end

  describe '#average_lifespan_by_century' do
    let!(:people) do
      create(:person,
             birth_attributes: { date: Date.new(1800, 01, 01) },
             death_attributes: { date: Date.new(1850, 01, 01)})
      create(:person,
             birth_attributes: { date: Date.new(1800, 01, 01) },
             death_attributes: { date: Date.new(1860, 01, 01)})
      create(:person,
             birth_attributes: { date: Date.new(1800, 01, 01) },
             death_attributes: { date: Date.new(1870, 01, 01)})
      create(:person,
             birth_attributes: { date: Date.new(1900, 01, 01) },
             death_attributes: { date: Date.new(1975, 01, 01)})
      create(:person,
             birth_attributes: { date: Date.new(1900, 01, 01) },
             death_attributes: { date: Date.new(1980, 01, 01)})
      create(:person,
             birth_attributes: { date: Date.new(1900, 01, 01) },
             death_attributes: { date: Date.new(1985, 01, 01)})
    end

    subject { get :average_lifespan_by_century, format: :json }

    it 'returns a hash mapping century to average age of death' do
      subject
      expect(json_response).to eq({ '19' => 60, '20' => 80 })
    end
  end
end
