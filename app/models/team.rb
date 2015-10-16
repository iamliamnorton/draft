class Team < ActiveRecord::Base
  belongs_to :sport

  has_many :players

  validates :name,
    uniqueness: {scope: :sport_id},
    presence: true
end
