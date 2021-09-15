class Genre < ApplicationRecord

  has_many :posts, dependent: :destroy

  scope :only_active, -> { where(is_active: true) }

end
