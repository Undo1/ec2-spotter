class CreateInstanceTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :instance_types do |t|
      t.string :api_name
      t.decimal :standard_price

      t.timestamps
    end
  end
end
