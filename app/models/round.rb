class Round < ActiveRecord::Base
  belongs_to :sport

  has_many :contests

  validates :name,
    presence: true

  def self.opened
    where('opened_at < ?', Time.now)
  end

  def self.open
    opened.where('closed_at > ?', Time.now)
  end
end
