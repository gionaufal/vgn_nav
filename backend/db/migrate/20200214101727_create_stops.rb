class CreateStops < ActiveRecord::Migration[6.0]
  def change
    create_table :stops, id: false do |t|
      t.string :stop_id, primary_key: true, null: false
      t.string :name
      t.float :lat
      t.float :lon
      t.string :location_type
      t.string :parent_station

      t.timestamps
    end
  end
end
