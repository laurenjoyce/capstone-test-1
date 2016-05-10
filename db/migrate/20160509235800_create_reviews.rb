class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.string :doctor_uid
      t.text :text
      t.integer :rating

      t.timestamps null: false
    end
  end
end
