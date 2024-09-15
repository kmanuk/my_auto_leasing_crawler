# db/migrate/xxxxxx_create_vehicles.rb
class CreateVehicles < ActiveRecord::Migration[7.2]
  def change
    create_table :vehicles do |t|
      t.string :make
      t.string :model
      t.integer :price
      t.timestamps
    end
  end
end
