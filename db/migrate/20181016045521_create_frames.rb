class CreateFrames < ActiveRecord::Migration[5.2]
  def change
    create_table :frames do |t|
      t.text :color_map
      t.integer :duration, default: 250
      t.belongs_to :animation, foreign_key: true
      t.integer :position
      t.integer :width, default: 75  # 16:9
      t.integer :height, default: 48 # 16:9

      t.timestamps
    end
  end
end
