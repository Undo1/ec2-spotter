class CreateSpotPrices < ActiveRecord::Migration[5.0]
  def change
    create_table :spot_prices do |t|
      t.decimal :price
      t.integer :availability_zone_id
      t.integer :instance_type_id

      t.timestamps
    end
  end
end
