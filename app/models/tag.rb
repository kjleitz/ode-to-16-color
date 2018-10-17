class Tag < ApplicationRecord
  extend FriendlyId

  has_many :animations_tags
  has_many :animations, through: :animations_tags

  friendly_id :name, use: :slugged

  validates :name, presence: true, uniqueness: true
end
