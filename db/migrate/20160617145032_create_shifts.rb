class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.references :work_site, null: false, index: true, foreign_key: true
      t.references :volunteer, null: false, index: true, foreign_key: true
      t.date       :day,       null: false
      t.timestamps             null: false
    end
  end
end
