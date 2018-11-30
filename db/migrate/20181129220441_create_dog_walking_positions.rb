class CreateDogWalkingPositions < ActiveRecord::Migration[5.2]
  def change
    create_table :dog_walking_positions do |t|
      t.references :dog_walking, foreign_key: true
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
