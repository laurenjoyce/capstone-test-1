class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :user_id
      t.string :doctor_uid
      t.text :text
      t.integer :answer_id
      t.string :status

      t.timestamps null: false
    end
  end
end
