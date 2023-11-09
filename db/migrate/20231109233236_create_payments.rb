class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :client, foreign_key: { to_table: :users }
      t.references :task, null: false, foreign_key: true
      t.string :transaction_id
      t.integer :status

      t.timestamps
    end
  end
end
