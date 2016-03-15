require 'rails_helper'

describe 'db:populate' do
  describe 'generated setters' do
    subject(:setter) { create :_setter_ }

    it 'has some associated setter_climb_logs (between 0 and 30)' do
      expect(setter.setter_story.setter_climb_logs.size).to be > 0
    end
  end
end
