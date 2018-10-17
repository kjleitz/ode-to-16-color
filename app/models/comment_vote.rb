class CommentVote < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  validates :value, presence: true, inclusion: { in: 1..3 }
end
