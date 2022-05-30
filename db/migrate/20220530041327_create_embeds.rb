class CreateEmbeds < ActiveRecord::Migration[6.1]
  def change
    create_table :embeds do |t|
      t.string :url
      t.string :raw_info

      t.timestamps
    end
  end
end
