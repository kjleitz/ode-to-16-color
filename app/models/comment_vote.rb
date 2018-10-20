class CommentVote < BaseVote
  belongs_to_votable :comment
end
