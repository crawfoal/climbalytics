require 'rails_helper'

describe BoulderLogPolicy do
  subject { BoulderLogPolicy.new(user, boulder_log) }
  let(:boulder_log) { create(:boulder_log) }
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
    let(:user) { create(:athlete_user) }

    it { should permit(:new) }

    context 'who owns the log' do
      let(:boulder_log) { user.athlete_story.boulder_logs.create }

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
