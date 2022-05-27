class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :map_id
      t.integer :rule_id
      t.integer :weapon_id
      t.string  :description

      t.timestamps
    end
  end
end
