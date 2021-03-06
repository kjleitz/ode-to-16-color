class Frame < ApplicationRecord
  PERMITTED_ATTRS = %i[
    color_map
    duration
    animation_id
    position
    width
    height
  ]

  belongs_to :animation

  serialize :color_map, JSON

  delegate :user, to: :animation

  # validates :position, presence: true, uniqueness: { scope: :animation_id }
  validates :duration, presence: true
  validates :color_map, presence: true
  # validate :frames_in_animation_are_equal_size

  # before_create :default_to_last_position!
  # before_create :default_to_white_color_map!

  default_scope { order(:animation_id, :position) }

  def previous_frames(inclusive: false)
    before_operator = inclusive ? '<=' : '<'
    animation.frames.where("position #{before_operator} ?", position)
  end

  def previous_frame
    previous_frames.last
  end

  def next_frames(inclusive: false)
    after_operator = inclusive ? '>=' : '>'
    animation.frames.where("position #{after_operator} ?", position)
  end

  def next_frame
    next_frames.first
  end

  def insert_at(new_position)
    return if new_position == position
    frames = animation.frames
    frames.where('position >= ?', new_position).update_all('position = position + 1')
    last_position = frames.last.position
    update(position: new_position > last_position ? last_position : new_position)
  end

  private

  # def default_to_last_position!
  #   self.position ||= animation.frames.last.position + 1
  # end

  # def default_to_white_color_map!
  #   self.color_map ||= height.times.map do |row|
  #     width.times.map do |column|
  #       '#FFFFFF'
  #     end
  #   end
  # end

  # def frames_in_animation_are_equal_size
  #   sizes = animation.frames.pluck(:width, :height)
  #   widths = sizes.map(&:first)
  #   heights = sizes.map(&:second)
  #   unless widths.uniq.count == 1 && heights.uniq.count == 1
  #     errors.add(:frames, 'must be equal sizes')
  #   end
  # end
end
