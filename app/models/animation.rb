class Animation < ApplicationRecord
  extend FriendlyId

  belongs_to :user
  has_many :frames, dependent: :destroy
  has_many :votes, class_name: AnimationVote, dependent: :destroy
  has_many :comments
  has_many :animations_tags
  has_many :tags, through: :animations_tags

  friendly_id :name, use: :slugged

  validates :name, presence: true
  validate :all_frames_are_equal_size

  def score
    @score ||= votes.pluck(:value).sum
  end

  def duration
    @duration ||= frames.pluck(:duration).sum
  end

  def frame_at(position)
    frames.find_by(position: position)
  end

  private

  def all_frames_are_equal_size
    sizes   = frames.pluck(:width, :height)
    widths  = sizes.map(&:first)
    heights = sizes.map(&:second)
    unless widths.uniq.count == 1 && heights.uniq.count == 1
      errors.add(:frames, 'must be equal sizes')
    end
  end
end
