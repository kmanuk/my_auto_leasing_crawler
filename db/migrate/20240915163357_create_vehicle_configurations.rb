class CreateVehicleConfigurations < ActiveRecord::Migration[7.2]
  def change
    create_table :vehicle_configurations do |t|
      t.integer :vehicle_type
      t.integer :fuel
      t.integer :transmission
      t.integer :year
      t.integer :horse_power
      t.timestamps
    end
  end
end
