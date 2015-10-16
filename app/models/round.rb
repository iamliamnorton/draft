class Round < ActiveRecord::Base
  has_many :games

  has_many :contests

  validates :name,
    presence: true

  def self.opened
    where('opened_at < ?', Time.now)
  end

  def self.not_closed
    where('closed_at > ?', Time.now)
  end

  def self.not_completed
    where('completed_at > ?', Time.now)
  end

  def self.open
    opened.not_closed.not_completed
  end
end
