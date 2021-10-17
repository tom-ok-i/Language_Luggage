class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, presence: true, uniqueness: true, length: {minimum: 2, maximum: 20}
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
  has_many :user_rooms
  has_many :chats
  # リレーションとクラス名が異なるため、クラス名を明記
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ?", current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  has_one_attached :image
  validate :image_type

  private

  def image_type
    if image.attached?
      if !image.blob.content_type.in?(%('image/jpeg image/png'))
        image.purge # Rails6では、この1行は必要ない
        errors.add(:image, 'はJPEGまたはPNG形式を選択してアップロードしてください')
      end
    end
  end


end
