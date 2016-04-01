require 'main_suite_helper'

describe 'db:populate' do
  describe 'generated gyms' do
    subject(:gym) { create :_gym_ }

    it 'has some sections' do
      expect(gym.sections.size).to be > 0
    end
  end
end
