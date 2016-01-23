require 'rails_helper'

describe SetterClimbLog do
  subject(:setter_climb_log) { create(:setter_climb_log) }

  it 'has a valid factory' do
    expect(setter_climb_log).to be_valid
  end

  describe '#setter' do

    context 'valid setter_climb_log, valid setter' do

      let(:user) { create(:setter_user) }
      subject(:setter_climb_log) { user.setter_story.setter_climb_logs.create }

      it "returns the setter's user model" do
        expect(setter_climb_log.setter).to be user
      end

    end

    context 'setter not defined' do
      it "returns nil" do
        expect(setter_climb_log.setter).to be_nil
      end
    end

  end

end
