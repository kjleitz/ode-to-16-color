class AnimationsTag < ActiveRecord::Base
  belongs_to :animations
  belongs_to :tags
end
