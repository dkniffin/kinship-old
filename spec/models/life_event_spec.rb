require 'rails_helper'

RSpec.describe LifeEvent, type: :model do
	before { @le = LifeEvent.create }

	subject { @le }

	it { is_expected.to respond_to(:date)}
	it { is_expected.to respond_to(:end_date)}
	it { is_expected.to respond_to(:person)}
	it { is_expected.to respond_to(:icon_class)}
end
