class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :animation
  has_many :votes, class_name: CommentVote, dependent: :destroy

  validates :body, presence: true
end
