require 'rails_helper'

describe Location do

  describe 'Associations' do
    it { should belong_to :locateable }
  end

  describe 'Validations' do
    it 'should have no validators' do
      expect(Location.validators.size).to be == 0
    end
  end

  context 'with valid attributes' do
    subject(:location) { create(:location, :with_address) }

    it { should be_valid }
    it 'accepts nested attributes for an address' do
      location.update(address_attributes: attributes_for(:address).merge(state_id: create(:state).id))
      expect(location.address).to be_persisted
    end
    it 'should be geocoded with the stubbed method during testing' do
      expect(location.latitude).to be_within(0.00001).of(40.7143528)
      expect(location.longitude).to be_within(0.00001).of(-74.0059731)
    end
    it 'should only be geocoded when the address changes' do
      expect(location).to_not receive(:address_geocode_format)
      location.latitude = 0
      location.save
    end
    it 'destroys address during destruction' do
      expect { location.destroy }.to change { location.address.destroyed? }.from(false).to(true)
    end
  end
end
