class AddMoviesToAnimations < ActiveRecord::Migration[5.2]
  def change
    add_column :animations, :movies, :text
  end
end
