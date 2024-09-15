# db/migrate/xxxxxx_create_vehicles.rb
class CreateVehicles < ActiveRecord::Migration[7.2]
  def change
    create_table :vehicles do |t|
      t.string :brand_name
      t.string :model_name
      t.timestamps
    end
  end
end
