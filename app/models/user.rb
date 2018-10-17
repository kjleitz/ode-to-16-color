class User < ApplicationRecord
  extend FriendlyId

  has_many :animations

  has_secure_password

  friendly_id :handle, use: :slugged

  validates :handle, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, maximum: 100 }

  enum role: {
    basic: 0,
    moderator: 1,
    admin: 2
  }

  # # NB: supplied by enum
  # scope :basic
  # scope :moderator
  # scope :admin
end
