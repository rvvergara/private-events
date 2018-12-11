class User < ApplicationRecord
  validates :name, presence: true
  has_secure_password

  has_many :attendances, foreign_key: :attendee_id

  has_many :events_attended, through: :attendances, source: :event

  has_many :events_created, foreign_key: :creator_id, class_name: "Event"

  def upcoming_events
    self.events_attended.where("date < ?", Date.today + 8.days)
  end

end
