require 'rails_helper'

describe Location do

  describe 'Associations' do
    it { should belong_to :locateable }
  end

  context 'with valid attributes' do
    subject(:location) { build(:location) }
    it { should be_valid }
    it 'accepts nested attributes for an address' do
      location = create(:location)
      location.update(address_attributes: attributes_for(:address).merge(state_id: create(:state).id))
      expect(location.address).to be_persisted
    end
    it 'should be geocoded with the stubbed method during testing' do
      location = create(:location)
      expect(location.latitude).to be_within(0.00001).of(40.7143528)
      expect(location.longitude).to be_within(0.00001).of(-74.0059731)
    end
    it 'should only be geocoded when the address changes' do
      location = build(:location)
      expect(location).to receive(:address_geocode_format).once
      location.save
      location.latitude = 0
      location.save
    end
    it 'destroys address during destruction' do
      location = create(:location)
      expect { location.destroy }.to change { location.address.destroyed? }.from(false).to(true)
    end
  end
end
