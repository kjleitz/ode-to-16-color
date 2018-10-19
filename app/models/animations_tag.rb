class AnimationsTag < ActiveRecord::Base
  belongs_to :animation
  belongs_to :tag
end
