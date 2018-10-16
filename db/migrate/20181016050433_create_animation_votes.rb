class CreateAnimationVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :animation_votes do |t|
      t.integer :value
      t.belongs_to :user, foreign_key: true
      t.belongs_to :animation, foreign_key: true

      t.timestamps
    end
  end
end
