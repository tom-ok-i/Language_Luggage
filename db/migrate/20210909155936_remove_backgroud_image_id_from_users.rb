class RemoveBackgroudImageIdFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :background_image_id, :string
  end
end
