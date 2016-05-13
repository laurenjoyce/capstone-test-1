class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :address
      t.string :insurance
      t.float :lat
      t.float :lon

      t.timestamps null: false
    end
  end
end
