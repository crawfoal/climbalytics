require 'rails_helper'

describe BoulderPolicy do

  subject { BoulderPolicy.new(user, boulder) }

  let(:boulder) { create(:boulder) }
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
    let(:user) { create(:setter_user) }

    context 'who owns the boulder problem' do
      let(:boulder) { user.setter_story.boulders.create }

      it { should permit(:create) }
      it { should permit(:edit) }
      it { should permit(:update) }
      it { should permit(:destroy) }
    end

    context "who does not own the boulder problem" do
      it { should_not permit(:create) }
      it { should_not permit(:edit) }
      it { should_not permit(:update) }
      it { should_not permit(:destroy) }
    end

  end

end
