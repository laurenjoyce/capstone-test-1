class AddUserIdToSavedDoctors < ActiveRecord::Migration
  def change
    add_column :saved_doctors, :user_id, :integer
  end
end
