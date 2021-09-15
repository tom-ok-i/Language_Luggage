class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :genre_id, presence: true
  validates :description, presence: true

  scope :where_genre_active, -> { joins(:genre).where(genres: {is_active: true}) }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  has_one_attached :image
end
