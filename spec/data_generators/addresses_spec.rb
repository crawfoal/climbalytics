require "rails_helper"
require "#{Rails.root}/lib/data_generators"

describe AddressGenerator do
  subject(:address_generator) { AddressGenerator.new }

  describe 'address created by #generate_one' do
    subject(:address) { address_generator.generate_one }
    it 'has a line 1' do
      expect(address.line1).to be_present
    end
    it 'has a city' do
      expect(address.city).to be_present
    end
    it 'has a state' do
      expect(address.state).to be_present
    end
    it 'has a zip' do
      expect(address.zip).to be_present
    end
  end
end
