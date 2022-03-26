class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :customer_id, null: false
      t.decimal :amount_sent, null: false, precision: 38, scale: 2
      t.string :currency_sent, null: false
      t.decimal :amount_recieved, null: false, precision: 38, scale: 2
      t.string :currency_recieved, null: false

      t.timestamps
    end
  end
end
