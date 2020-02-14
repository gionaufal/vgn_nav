class CreateTransfers < ActiveRecord::Migration[6.0]
  def change
    create_table :transfers do |t|
      t.string :from_stop_id, null: false
      t.string :to_stop_id, null: false
      t.integer :transfer_type
      t.integer :min_transfer_time

      t.timestamps
    end
  end
end
