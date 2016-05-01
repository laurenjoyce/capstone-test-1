class AddDoctorUidToSavedDoctors < ActiveRecord::Migration
  def change
    add_column :saved_doctors, :doctor_uid, :string
  end
end
