class AddGymToClimb < ActiveRecord::Migration
  def change
    add_reference :climbs, :gym_section, index: true, foreign_key: true
  end
end
