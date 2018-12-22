class Invitation < ApplicationRecord
  belongs_to :event
  belongs_to :invitee, class_name: "User"

  # Update accepted attribute to true
  def accept
    update(accepted: true)
    update(declined:false) if declined
  end

  # Update decline attribute to true
  def decline
    update(declined: true)
    update(accepted:false) if accepted
  end
end
