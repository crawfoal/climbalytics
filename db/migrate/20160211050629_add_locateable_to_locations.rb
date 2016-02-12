class AddLocateableToLocations < ActiveRecord::Migration
  def change
    add_reference :locations, :locateable, polymorphic: true, index: true
  end
end
