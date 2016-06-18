class CreateReportRecipients < ActiveRecord::Migration
  def change
    create_table :report_recipients do |t|
      t.string :email

      t.timestamps null: false
    end
  end
end
