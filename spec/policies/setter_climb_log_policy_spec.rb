require 'rails_helper'

describe SetterClimbLogPolicy do

  subject { SetterClimbLogPolicy.new(user, setter_climb_log) }

  let(:setter_climb_log) { create(:setter_climb_log) }
  let(:user) { create(:user) }

  context 'for any user' do
    it { should permit(:show) }
  end

  context 'for a non-setter user' do
    it { should_not permit(:create) }
    it { should_not permit(:edit) }
    it { should_not permit(:update) }
    it { should_not permit(:destroy) }
  end

  context 'for a setter' do
    let(:user) { create(:user, roles: [:setter]) }

    context 'who owns the setter_climb_log problem' do
      let(:setter_climb_log) { user.setter_story.setter_climb_logs.create }

      it { should permit(:create) }
      it { should permit(:edit) }
      it { should permit(:update) }
      it { should permit(:destroy) }
    end

    context "who does not own the setter_climb_log problem" do
      it { should_not permit(:create) }
      it { should_not permit(:edit) }
      it { should_not permit(:update) }
      it { should_not permit(:destroy) }
    end

  end

end
