class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :password_digest
      t.decimal :balance, default: 0.0
      t.string :address, default: ''
      t.string :role, default: 'customer'
      t.date :payment_date
      t.string :image
      t.string :phone_number
      t.string :email
      t.string :last_name
      t.string :first_name
      t.string :uid, default: 'system'
      t.string :provider, default: 'system'
      t.integer :meter_number
      t.decimal :amount, default: 0.0

      t.timestamps
    end
  end
end
