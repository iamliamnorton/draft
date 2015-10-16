class Team < ActiveRecord::Base
  belongs_to :sport

  has_many :players

  validates :sport_id,
    presence: true

  validates :name,
    uniqueness: {scope: :sport_id},
    presence: true
end
