class CreateLeasingOffers < ActiveRecord::Migration[7.2]
  def change
    create_table :leasing_offers do |t|
      t.references :vehicle, foreign_key: true
      t.references :vehicle_configuration, foreign_key: true
      t.decimal :monthly_price
      t.integer :duration
      t.decimal :mileage
      t.decimal :price_primary
      t.decimal :price_secondary
      t.timestamps
    end
  end
end
