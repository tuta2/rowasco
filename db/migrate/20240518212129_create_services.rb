class CreateServices < ActiveRecord::Migration[7.1]
  def change
    create_table :services do |t|
      t.string :service_type
      t.string :service_quantity
      t.decimal :price
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
