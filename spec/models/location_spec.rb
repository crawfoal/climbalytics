require 'rails_helper'

describe Location do

  describe 'Associations' do
    it { should belong_to :locateable }
  end

  describe 'Validations' do
    it { should validate_numericality_of :latitude }
    it { should validate_numericality_of :longitude }
  end

  context 'with valid attributes' do
    subject(:location) { build(:location) }

    it { should be_valid }
    it 'accepts nested attributes for an address' do
      location.update(address_attributes: attributes_for(:address).merge(state_id: create(:state).id))
      expect(location.address).to be_persisted
    end

    context 'with a valid address' do
      subject(:location) { create(:location, :with_address) }

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
end

describe 'location and address default factories:' do
  it 'more than one location can be created' do
    expect { 2.times { create(:location) } }.to change { Location.count }.by(2)
  end
  it 'an address and a location can be created' do
    expect { create(:address) }.to change { Address.count }.by(1)
    expect { create(:location) }.to change { Location.count }.by(1)
  end
  it 'an address is created when a location is created with the :with_address option' do
    expect { create(:location, :with_address) }.to change { Address.count }.by(1)
  end
end
