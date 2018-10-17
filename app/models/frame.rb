class Frame < ApplicationRecord
  default_scope { order(:animation_id, :position) }

  belongs_to :animation

  serialize :color_map, JSON

  validates :position, presence: true, uniqueness: { scope: :animation_id }
  validates :duration, presence: true

  before_create :default_to_last_position!

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

  def default_to_last_position!
    self.position ||= animation.frames.last.position + 1
  end
end
