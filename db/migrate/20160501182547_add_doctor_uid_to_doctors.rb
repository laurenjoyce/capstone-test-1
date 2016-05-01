class AddDoctorUidToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :doctor_uid, :string
  end
end
