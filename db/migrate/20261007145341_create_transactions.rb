class CreateTransactions < ActiveRecord::Migration[8.1]
  def change
    create_table :transactions do |t|
      t.integer :sender_wallet_id
      t.integer :receiver_wallet_id
      t.integer :amount

      t.timestamps
    end
  end
end
