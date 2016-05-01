class CreateSavedDoctors < ActiveRecord::Migration
  def change
    create_table :saved_doctors do |t|

      t.timestamps null: false
    end
  end
end
