class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :attendances, foreign_key: :event_id

  has_many :attendees, through: :attendance
end
