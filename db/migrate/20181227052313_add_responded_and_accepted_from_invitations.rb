class AddRespondedAndAcceptedFromInvitations < ActiveRecord::Migration[5.2]
  def change
    add_column :invitations, :responded, :boolean, default: false
    add_column :invitations, :accepted, :boolean
  end
end
