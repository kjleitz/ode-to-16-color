class BaseVote < ApplicationRecord
  self.abstract_class = true

  class << self
    # Must use this macro in child class.
    # e.g., belongs_to_votable :animation
    def belongs_to_votable(votable_model)
      @votable_model_name = votable_model.to_s.downcase.to_sym
      belongs_to @votable_model_name
    end

    def votable_model_name
      @votable_model_name
    end
  end

  MIN_VOTE_VALUE = 1
  MAX_VOTE_VALUE = 3

  belongs_to :user

  validates :value, presence: true, inclusion: { in: MIN_VOTE_VALUE..MAX_VOTE_VALUE }
  validate :no_duplicate_votes

  private

  def no_duplicate_votes
    max_prev_votes = persisted? ? 1 : 0
    prev_votes = votable_model.votes.where(user_id: user.id).count
    errors.add(:user, "cannot vote multiple times") if prev_votes > max_prev_votes
  end

  def votable_model
    send(self.class.votable_model_name)
  end
end
