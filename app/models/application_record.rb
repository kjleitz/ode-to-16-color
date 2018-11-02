class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  default_scope { defined?(friendly) ? friendly : all }

  # class << self
  #   def friendly
  #     defined()
  #   end
  # end
end
