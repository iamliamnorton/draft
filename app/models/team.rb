class Team < ActiveRecord::Base
  belongs_to :season

  has_many :players

  has_many :games

  validates :name,
    presence: true
end
