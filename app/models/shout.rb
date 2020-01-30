class Shout < ApplicationRecord
  belongs_to :user
  belongs_to :content, polymorphic: true

  validates :user, presence: true 

  default_scope { order(created_at: :desc)}

  # highlights that username is a relationship between the user and a shout
  # provides additional context
  delegate :username, to: :user
end
