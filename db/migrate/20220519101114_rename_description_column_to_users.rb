class RenameDescriptionColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :description, :nickname
  end
end
