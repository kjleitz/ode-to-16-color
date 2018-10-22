class AddMovieToAnimations < ActiveRecord::Migration[5.2]
  def change
    add_column :animations, :movie, :text
  end
end
