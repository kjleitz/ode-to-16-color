class AnimationVote < ApplicationRecord
  belongs_to :user
  belongs_to :animation

  validates :value, presence: true, inclusion: { in: 1..3 }
end
