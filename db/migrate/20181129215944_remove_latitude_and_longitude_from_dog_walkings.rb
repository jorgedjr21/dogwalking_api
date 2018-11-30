class RemoveLatitudeAndLongitudeFromDogWalkings < ActiveRecord::Migration[5.2]
  def change
    remove_column :dog_walkings, :latitude
    remove_column :dog_walkings, :longitude
  end
end
