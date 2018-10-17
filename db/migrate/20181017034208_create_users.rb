class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :handle
      t.string :password_digest
      t.string :first_name, default: ''
      t.string :last_name, default: ''
      t.string :email
      t.string :phone, default: ''
      t.text :bio, default: ''
      t.string :signature, default: ''
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
