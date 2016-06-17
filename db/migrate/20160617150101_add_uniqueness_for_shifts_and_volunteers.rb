class AddUniquenessForShiftsAndVolunteers < ActiveRecord::Migration
  def change
    add_index :volunteers, :email, unique: true

    add_index :shifts, [:work_site_id, :volunteer_id, :day], unique: true
  end
end
