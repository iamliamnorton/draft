class Stat < ActiveRecord::Base
  belongs_to :player

  belongs_to :game

  validates :points,
    presence: true
end
