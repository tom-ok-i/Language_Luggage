class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, uniqueness: true, length: {minimum: 2, maximum: 20}
  validates :introduction, length: {maximum: 50}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :follower, foreign_key: "followed_id", class_name: "Relationship"
  has_many :following, foreign_key: "follower_id", class_name: "Relationship"

  has_many :followers, through: :follower, source: :follower
  has_many :followings, through: :following, source: :followed

  has_one_attached :image

  def followed_by(user)
    self.follower.where(follower_id:user.id).exists?
  end

end
