class CreateAnimations < ActiveRecord::Migration[5.2]
  def change
    create_table :animations do |t|
      t.belongs_to :user, foreign_key: true
      t.string :name, default: 'untitled'
      t.text :description, default: ''

      t.timestamps
    end
  end
end
