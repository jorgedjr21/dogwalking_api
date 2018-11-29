class CreateDogWalkings < ActiveRecord::Migration[5.2]
  def change
    create_table :dog_walkings do |t|
      t.integer  :status
      t.datetime :schedule_date
      t.decimal  :price
      t.integer  :duration
      t.decimal  :latitude
      t.decimal  :longitude
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
