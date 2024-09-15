# db/migrate/xxxxxx_create_leases.rb
class CreateLeases < ActiveRecord::Migration[7.2]
  def change
    create_table :leases do |t|
      t.references :vehicle, foreign_key: true
      t.integer :monthly_price
      t.integer :duration
      t.timestamps
    end
  end
end
