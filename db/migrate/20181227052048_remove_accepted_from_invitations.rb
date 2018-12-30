class RemoveAcceptedFromInvitations < ActiveRecord::Migration[5.2]
  def change
    remove_column :invitations, :accepted
  end
end
