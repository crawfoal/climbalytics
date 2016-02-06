require 'rails_helper'

describe KeyInspector do
  describe "#foreign_key_columns" do
    it "includes foreign keys that are in this model's table" do
      expect(SetterStory.foreign_key_columns['user_id']).to be == SetterStory.reflections['user']
    end
    it "doesn't include foreign keys that are in an associated model's table" do
      expect(SetterStory.foreign_key_columns).to_not include 'setter_story_id'
    end
  end
end
