class Animation < ApplicationRecord
  belongs_to :user
  has_many :frames, dependent: :destroy
  has_many :votes, class_name: AnimationVote, dependent: :destroy
  has_many :comments
  has_many :animations_tags
  has_many :tags, through: :animations_tags

  validates :name, presence: true

  def score
    @score ||= votes.pluck(:value).sum
  end

  def duration
    @duration ||= frames.pluck(:duration).sum
  end

  def frame_at(position)
    frames.find_by(position: position)
  end
end
