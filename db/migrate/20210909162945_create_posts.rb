class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :genre_id
      t.string :title
      t.text :discription

      t.timestamps
    end
  end
end
