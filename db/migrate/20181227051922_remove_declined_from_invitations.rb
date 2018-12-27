class RemoveDeclinedFromInvitations < ActiveRecord::Migration[5.2]
  def change
    remove_column :invitations, :declined
  end
end
