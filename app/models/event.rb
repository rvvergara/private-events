class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :attendances, foreign_key: :event_id
  has_many :attendees, through: :attendances
  default_scope -> {order(created_at: :desc)}
  scope :upcoming_events, -> {where("date < ? AND date > ?", Date.today + 8.days, Date.today)}
  scope :past_events, -> {where("date < ?", Date.today)}
  mount_uploader :picture, PictureUploader
  validates :title, :date, :venue, :description, presence: true

  def add_attendee(user)
    self.attendees.push(user)
  end

  def event_date
    self.date.localtime.to_s.gsub(/.\+.{4}/, '')
  end
end
