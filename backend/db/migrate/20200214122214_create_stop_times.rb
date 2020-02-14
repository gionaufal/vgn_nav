class CreateStopTimes < ActiveRecord::Migration[6.0]
  def change
    create_table :stop_times do |t|
      t.string :trip_id
      t.string :arrival_time, null: false
      t.string :departure_time, null: false
      t.string :stop_id, null: false
      t.integer :stop_sequence, null: false
      t.string :stop_headsign
      t.string :pickup_type
      t.string :drop_off_type

      t.timestamps
    end
  end
end
