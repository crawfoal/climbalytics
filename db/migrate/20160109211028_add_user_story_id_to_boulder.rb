class AddUserStoryIdToBoulder < ActiveRecord::Migration
  def change
    add_reference :boulders, :setter_story, index: true, foreign_key: true
  end
end
