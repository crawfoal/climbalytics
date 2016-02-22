require 'rails_helper'
require "#{Rails.root}/lib/data_generators"

describe LocationGenerator do
  context 'by default' do
    subject(:location_generator) { LocationGenerator.new }

    it 'uses the generic_location factory' do
      expect(location_generator.factory_name).to be == :generic_location
    end

    describe '#initialize' do
      it 'sets rand_lat_long? to a true value' do
        expect(location_generator.rand_lat_long?).to be_truthy
      end
    end

    describe 'location created by #generate_one' do
      subject(:location) { location_generator.generate_one }

      it 'has a latitude' do
        expect(location.latitude).to be_a Float
      end
      it 'has a longitude' do
        expect(location.longitude).to be_a Float
      end

      it 'has an address' do
        expect(location.address).to be_present
      end
    end
  end

  context 'with an argument of `rand_lat_long: false`' do
    subject(:location_generator) { LocationGenerator.new(rand_lat_long: false) }

    describe '#initialize' do
      it 'sets rand_lat_long? to a false value' do
        expect(location_generator.rand_lat_long?).to be_falsey
      end
    end

    describe 'location created by #generate_one' do
      subject(:location) { location_generator.generate_one }

      context 'with `include_*?` stubbed out to true' do
        before :each do
          allow(location_generator).to receive(:include_address?).and_return(true)
        end
        it 'includes an address' do
          expect(location.address).to be_present
        end
        it 'gets a latitude and longitude from the stub' do
          location
          expect(location.latitude).to be_within(0.000001).of(40.7143528)
          expect(location.longitude).to be_within(0.000001).of(-74.0059731)
        end
      end

      context 'with `include_*?` stubbed out to false' do
        before { allow(location_generator).to receive(:include_address?).and_return(false) }
        it 'does not include an address' do
          expect(location.address).to_not be_present
        end
        it 'does not get a latitude and longitude' do
          expect(location.latitude).to_not be_present
          expect(location.longitude).to_not be_present
        end
      end
    end
  end

end

describe 'generic factories:' do
  it 'more than one location can be created' do
    expect { 2.times { create(:generic_location) } }.to change { Location.count }.by(2)
  end
  it 'an address and a location can be created' do
    expect { create(:generic_address) }.to change { Address.count }.by(1)
    expect { create(:generic_location) }.to change { Location.count }.by(1)
  end
  it 'two addresses can be created' do
    expect { 2.times { create(:generic_address) } }.to change { Address.count }.by(2)
  end
  it 'an address is created when a location is created' do
    expect { create(:generic_location) }.to change { Address.count }.by(1)
  end
  describe ':generic_location' do
    subject(:location) { build(:generic_location) }
    it 'has a corresponding Geocoder stub' do
      expect(Geocoder::Lookup::Test.stubs.keys).to include location.address_geocode_format
    end
  end
end
