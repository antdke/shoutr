class User < ApplicationRecord
  include Clearance::User

  validates :username, presence: true, uniqueness: true 

  has_many :shouts, dependent: :destroy
  has_many :likes
  has_many :liked_shouts, through: :likes, source: :shout

  def like(shout)
    liked_shouts << shout
  end
end
