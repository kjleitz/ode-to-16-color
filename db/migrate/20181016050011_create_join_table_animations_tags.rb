class CreateJoinTableAnimationsTags < ActiveRecord::Migration[5.2]
  def change
    create_join_table :tags, :animations do |t|
      t.index [:tag_id, :animation_id]
      t.index [:animation_id, :tag_id]
    end
  end
end
