class AddIndexToAttendances < ActiveRecord::Migration[5.2]
  def change
    add_index :attendances, [:attendee_id, :event_id], unique: true

  end
end
