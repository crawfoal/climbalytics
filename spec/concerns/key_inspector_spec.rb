require 'rails_helper'

describe KeyInspector do
  describe "#has_fk?" do
    context 'foreign key exists' do
      subject { SetterStory.has_fk?(:user_id) }
      it { should be true }
    end
    context 'foreign key does not exist' do
      subject { User.has_fk?(:user_id) }
      it { should be false }
    end
  end
  describe "#get_reflection_via_fk" do
    context "when the foreign key is in this model's table" do
      it "should return the association's reflection" do
        expect(SetterStory.get_reflection_via_fk('user_id')).to be == SetterStory.reflections['user']
      end
    end
    context "when the foreign key is not in this model's table" do
      it "should return nil" do
        expect(SetterStory.get_reflection_via_fk('setter_story_id')).to be nil
      end
    end
  end
end
