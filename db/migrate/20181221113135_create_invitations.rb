class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.references :event, foreign_key: true
      t.references :invitee

      t.timestamps
    end
    add_foreign_key :invitations, :users, column: :invitee_id, primary_key: :id
    add_index :invitations, [:invitee_id, :event_id], unique: true
  end
end
