# db/migrate/xxxxxx_create_vehicles.rb
class CreateVehicles < ActiveRecord::Migration[7.2]
  def change
    create_table :vehicles do |t|
      t.references :vehicle_brand, foreign_key: true
      t.string :car_name
      t.timestamps
    end
  end
end
