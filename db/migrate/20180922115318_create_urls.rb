class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.string :original_url
      t.string :short_url
      t.string :random_string
      t.integer :user_id

      t.timestamps
    end
  end
end
