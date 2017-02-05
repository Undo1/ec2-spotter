class CreateAvailabilityZones < ActiveRecord::Migration[5.0]
  def change
    create_table :availability_zones do |t|
      t.string :api_name
      t.integer :region_id

      t.timestamps
    end
  end
end
