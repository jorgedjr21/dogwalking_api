class CreateDogWalkingsPets < ActiveRecord::Migration[5.2]
  def change
    create_table :dog_walkings_pets do |t|
      t.references :pet, foreign_key: true
      t.references :dog_walking, foreign_key: true

      t.timestamps
    end
  end
end
