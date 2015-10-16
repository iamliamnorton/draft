class Roster < ActiveRecord::Base
  belongs_to :user

  belongs_to :contest

  has_many :roster_spots
end
