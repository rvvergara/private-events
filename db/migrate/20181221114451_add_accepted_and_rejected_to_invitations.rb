class AddAcceptedAndRejectedToInvitations < ActiveRecord::Migration[5.2]
  def change
    add_column :invitations, :accepted, :boolean, default: false
    add_column :invitations, :decline, :boolean, default: false
  end
end
