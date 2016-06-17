class CreateWorkSites < ActiveRecord::Migration
  def change
    create_table :work_sites do |t|
      t.text :address, null: false
      t.timestamps     null: false
    end
  end
end
