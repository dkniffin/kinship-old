require 'spec_helper'

RSpec.describe Source, type: :model do
  subject { build(:source) }

  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:url) }
  it { is_expected.to respond_to(:citation_body) }
  it { is_expected.to respond_to(:references) }
  it { is_expected.to respond_to(:referenceables) }

  it { is_expected.to be_valid }

  context 'without a title' do
    subject { build(:source, title: nil) }

    it { is_expected.to be_invalid }
  end
end
