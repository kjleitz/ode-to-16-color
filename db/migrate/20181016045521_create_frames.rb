class CreateFrames < ActiveRecord::Migration[5.2]
  def change
    create_table :frames do |t|
      t.text :color_map
      t.integer :duration
      t.belongs_to :animation, foreign_key: true
      t.integer :index

      t.timestamps
    end
  end
end
