class Animation < ApplicationRecord
  extend FriendlyId

  PERMITTED_ATTRS = %i[
    name
    description
    movie
  ]

  belongs_to :user
  has_many :frames, dependent: :destroy
  has_many :votes, class_name: 'AnimationVote', dependent: :destroy
  has_many :comments
  has_many :animations_tags
  has_many :tags, through: :animations_tags

  mount_uploader :movie, MovieUploader
  serialize :movie, JSON

  friendly_id :name, use: :slugged

  validates :name, presence: true
  validate :all_frames_are_equal_size

  # The error message for validates_associated will simply be "is invalid"; for
  # detailed errors check the child.
  validates_associated :tags
  validates_associated :frames

  accepts_nested_attributes_for :tags
  accepts_nested_attributes_for :frames

  def tags_attributes=(tags_attributes)
    self.tags = tags_attributes.map do |tag_attributes|
      Tag.where(name: tag_attributes[:name]).first_or_create(tag_attributes)
    end
  end

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
    sizes = frames.pluck(:width, :height)
    widths = sizes.map(&:first)
    heights = sizes.map(&:second)
    unless widths.uniq.count == 1 && heights.uniq.count == 1
      errors.add(:frames, 'must be equal sizes')
    end
  end
end
