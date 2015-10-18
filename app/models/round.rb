class Round < ActiveRecord::Base
  has_many :games

  has_many :contests

  validates :name,
    presence: true

  def self.incomplete
    where(completed_at: nil)
  end

  def self.open
    incomplete.
      where('opened_at < ?', Time.now).
      where('closed_at > ?', Time.now)
  end

  def self.closed
    incomplete.
      where('closed_at < ?', Time.now)
  end

  def open?
    opened_at < Time.now && closed_at > Time.now && completed_at.nil?
  end
end
