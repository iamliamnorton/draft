class Player < ActiveRecord::Base
  belongs_to :team

  has_many :draft_picks

  has_many :stats

  validates :name,
    presence: true

  validates :salary,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0
    }

  def self.by_source(id)
    where(source_id: id).last
  end

  def self.for_round(round)
    team_ids = round.games.pluck(:home_team_id, :away_team_id).flatten

    where(team_id: team_ids)
  end
end
