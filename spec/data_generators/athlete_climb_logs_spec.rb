require 'rails_helper'
require "#{Rails.root}/lib/helpers/data_generators"

describe ClimbLogGenerator do
  subject(:climb_log_generator) { ClimbLogGenerator.new(min: 2, max: 2) }

  describe '#initialize' do
    context 'by default' do
      subject(:user_generator) { ClimbLogGenerator.new }
      it 'sets @min = 10' do
        expect(user_generator.min).to be == 10
      end
      it 'sets @max = 30' do
        expect(user_generator.max).to be == 30
      end
    end
  end
end
