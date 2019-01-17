class AddForeignKeysToAttendances < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :attendances, :events
    add_foreign_key :attendances, :users, column: :attendee_id
  end
end
