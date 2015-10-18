class Player < ActiveRecord::Base
  belongs_to :team

  has_many :draft_picks

  has_many :stats

  validates :name,
    presence: true

  validates :position,
    presence: true

  validates :salary,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1
    }

  def self.for_round(round)
    where(team_id: round.games.pluck(:team_id))
  end
end
