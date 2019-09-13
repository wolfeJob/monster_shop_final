class AddAddressesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :addresses, :users, foreign_key: true
  end
end
