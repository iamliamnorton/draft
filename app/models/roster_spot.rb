class RosterSpot < ActiveRecord::Base
  belongs_to :roster

  belongs_to :player

  validates :cost,
    presence: true
end
