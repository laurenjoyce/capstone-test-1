class AddStatusToSavedDoctors < ActiveRecord::Migration
  def change
    add_column :saved_doctors, :status, :string
  end
end
