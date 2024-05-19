class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :order_uniq_id
      t.decimal :total_amount, default: 0.0
      t.string :mode_of_payment
      t.string :phone_number
      t.string :account_number
      t.string :full_name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
