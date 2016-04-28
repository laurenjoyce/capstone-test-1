class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :education
      t.string :practice
      t.string :bio
      t.string :license
      t.string :photo

      t.timestamps null: false
    end
  end
end
