class AddActiveToWorkSites < ActiveRecord::Migration
  def change
    add_column :work_sites, :active, :boolean, default: true, null: false
  end
end
