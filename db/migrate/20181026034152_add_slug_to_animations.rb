class AddSlugToAnimations < ActiveRecord::Migration[5.2]
  def change
    add_column :animations, :slug, :string
    add_index :animations, :slug
  end
end
