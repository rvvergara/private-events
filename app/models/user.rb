class User < ApplicationRecord
  attribute :new_token
  validates :name, :email, presence: true
  has_secure_password

  has_many :attendances, foreign_key: :attendee_id

  has_many :events_attended, through: :attendances, source: :event

  has_many :events_created, foreign_key: :creator_id, class_name: "Event"

  def upcoming_events
    self.events_attended.where("date < ? AND date > ?", Date.today + 8.days, Date.today)
  end

  def past_events
    self.events_attended.where("date < ?", Date.today)
  end

  # For use in factories and remembering users later on - from RailsTutorial ch8 section 8.2.4
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # For use in generating remember tokens and also password reset tokens/activation tokens
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Saves a new remember_digest into the database
  def remember
    update_attribute(:remember_digest, User.digest(User.new_token))
  end
end
