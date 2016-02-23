require 'rails_helper'

describe AthleteClimbLogPolicy do
  subject { AthleteClimbLogPolicy.new(user, athlete_climb_log) }
  let(:athlete_climb_log) { create(:athlete_climb_log) }
  let(:user) { create(:user) }

  context 'for any user' do
    it { should_not permit(:index) }
    it { should_not permit(:show) }
    it { should_not permit(:new) }
    it { should_not permit(:create) }
    it { should_not permit(:edit) }
    it { should_not permit(:update) }
    it { should_not permit(:destroy) }
  end

  context 'for an athlete' do
    let(:user) { create(:athlete) }

    it { should permit(:new) }

    context 'who owns the log' do
      let(:athlete_climb_log) { user.athlete_story.athlete_climb_logs.create }

      xit { should permit(:index) }
      it { should permit(:show) }
      it { should permit(:create) }
      it { should permit(:edit) }
      it { should permit(:update) }
      it { should permit(:destroy) }
    end

    context 'who does not own the log' do
      it { should_not permit(:index) }
      it { should_not permit(:show) }
      it { should_not permit(:create) }
      it { should_not permit(:edit) }
      it { should_not permit(:update) }
      it { should_not permit(:destroy) }
    end

  end
end
