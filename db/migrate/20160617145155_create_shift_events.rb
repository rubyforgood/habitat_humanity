class CreateShiftEvents < ActiveRecord::Migration
  def change
    create_table :shift_events do |t|
      t.references :shift,       null: false, index: true, foreign_key: true
      t.string     :action,      null: false
      t.datetime   :occurred_at, null: false
      t.text       :signature
      t.timestamps               null: false
    end
  end
end
