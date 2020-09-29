class AddAddressToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :shipping_addres, :string
  end
end
