class Invitation < ApplicationRecord
  belongs_to :event
  belongs_to :invitee, class_name: "User"

  # Update accepted attribute to true
  def accept
    update(accepted: true)
  end

  # Update decline attribute to true
  def decline
    update(declined: true)
  end
end
