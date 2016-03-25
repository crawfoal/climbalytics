require 'rails_helper'

describe 'db:populate' do
  describe 'generated climb seshes' do
    subject(:climb_sesh) { create :_climb_sesh_ }

    it 'has a high hold marked (4/5 of the time)' do
      expect(climb_sesh.high_hold).to_not be_nil
    end

    it 'has a note (1/5 of the time)' do
      expect(climb_sesh.note).to_not be_nil
    end
  end
end
