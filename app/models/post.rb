class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :genre_id, presence: true
  validates :description, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  has_one_attached :image

  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(title: content)
    elsif method == 'forward'
      Post.where('title LIKE ?', content + '%')
    elsif method == 'backward'
      Post.where('title LIKE ?', '%' + content)
    else
      Post.where('title LIKE ?', '%' + content + '%')
    end
  end

end
