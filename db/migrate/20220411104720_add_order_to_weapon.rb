class AddOrderToWeapon < ActiveRecord::Migration[6.1]
  def change
    add_column :weapons, :order, :integer
  end
end
