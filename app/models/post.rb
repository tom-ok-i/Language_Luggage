class Post < ApplicationRecord

  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  has_one_attached :image

  validate :image_type

private

def image_type
  if !image.blob.content_type.in?(%('image/jpeg image/png'))
    image.purge # Rails6では、この1行は必要ない
    errors.add(:image, 'はJPEGまたはPNG形式を選択してアップロードしてください')
  end
end

end
