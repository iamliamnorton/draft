class Team < ActiveRecord::Base
  belongs_to :sport

  has_many :players

  has_many :games

  validates :name,
    presence: true
end
