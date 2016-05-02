class AddApiInfoToSavedDoctors < ActiveRecord::Migration
  def change
    add_column :saved_doctors, :api_info, :string
  end
end
