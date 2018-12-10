class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.integer :event_id
      t.integer :attendee_id

      t.timestamps
    end
  end
end
