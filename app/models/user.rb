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

  #自分がフォローされる側の関係性
  has_many :reverse_of_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  #自分がフォローする側の関係性
  has_many :relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy

  #自分をフォローしている人(上記reverse_of_relationshipsを通じて参照)
  has_many :followers, through: :reverse_of_relationships, source: :follower
  #自分がフォローしている人(上記relationshipsを通じて参照)
  has_many :followings, through: :relationships, source: :followed

  has_one_attached :image

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

end
