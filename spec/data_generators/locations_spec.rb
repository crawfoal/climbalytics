require 'rails_helper'
require "#{Rails.root}/lib/data_generators"

describe LocationGenerator do
  subject(:location_generator) { LocationGenerator.new }

  describe 'location created by #generate_one' do
    subject(:location) { location_generator.generate_one }

    context 'with `include_*?` stubbed out to true' do
      it 'includes an address' do
        allow(location_generator).to receive(:include_address?).and_return(true)
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
