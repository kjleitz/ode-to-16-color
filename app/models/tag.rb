class Tag < ApplicationRecord
  has_many :animations_tags
  has_many :animations, through: :animations_tags

  validates :name, presence: true, uniqueness: true
end
