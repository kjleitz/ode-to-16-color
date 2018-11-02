class User < ApplicationRecord
  extend FriendlyId

  PERMITTED_ATTRS = %i[
    handle
    password
    password_confirmation
    first_name
    last_name
    email
    phone
    bio
    signature
  ]

  has_many :animations

  has_secure_password

  friendly_id :handle, use: :slugged

  validates :handle, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, maximum: 100 }, confirmation: true

  enum role: {
    basic: 0,
    moderator: 1,
    admin: 2
  }

  # # NB: supplied by enum
  # scope :basic
  # scope :moderator
  # scope :admin

  def name
    "#{first_name.strip} #{last_name.strip}".strip
  end
end
