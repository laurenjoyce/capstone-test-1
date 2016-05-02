class RemoveApiInfoFromSavedDoctors < ActiveRecord::Migration
  def change
    remove_column :saved_doctors, :api_info, :string
  end
end
