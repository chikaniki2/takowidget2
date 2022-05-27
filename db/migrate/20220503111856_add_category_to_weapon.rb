class AddCategoryToWeapon < ActiveRecord::Migration[6.1]
  def change
    add_column :weapons, :category, :string #類似検索用にカラム追加
  end
end
