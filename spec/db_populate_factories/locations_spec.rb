require 'rails_helper'

describe 'db:populate' do
  describe 'generated locations' do
    subject(:location) { create :_location_ }

    it 'has an address' do
      expect(location.address).to be_present
    end
  end
end
