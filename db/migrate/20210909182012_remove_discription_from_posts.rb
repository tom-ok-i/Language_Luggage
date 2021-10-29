class RemoveDiscriptionFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :discription, :text
  end
end
