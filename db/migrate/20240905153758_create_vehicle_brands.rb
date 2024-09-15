# db/migrate/xxxxxx_create_vehicles.rb
class CreateVehicleBrands < ActiveRecord::Migration[7.2]
  def change
    create_table :vehicle_brands do |t|
      t.string :brand_name
      t.timestamps
    end
  end
end
