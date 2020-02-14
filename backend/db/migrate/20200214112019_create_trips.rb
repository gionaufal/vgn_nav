class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips, id: false do |t|
      t.string :trip_id, primary_key: true
      t.string :route_id
      t.string :service_id
      t.string :headsign
      t.integer :direction
      t.integer :block

      t.timestamps
    end
  end
end
