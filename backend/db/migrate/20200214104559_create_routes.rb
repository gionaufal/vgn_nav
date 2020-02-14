class CreateRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :routes, id: false do |t|
      t.string :route_id, primary_key: true, null: false
      t.string :short_name
      t.string :long_name
      t.integer :route_type
      t.string :color
      t.string :text_color

      t.timestamps
    end
  end
end
