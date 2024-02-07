class AddNetworkToPayment < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :network, :string
  end
end
