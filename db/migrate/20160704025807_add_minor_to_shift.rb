class AddMinorToShift < ActiveRecord::Migration
  def change
    add_column :shifts, :minor, :boolean, default: false, null: false
  end
end
