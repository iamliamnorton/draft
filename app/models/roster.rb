class Roster < ActiveRecord::Base
  belongs_to :user

  belongs_to :contest

  has_many :draft_picks

  has_many :players,
    through: :draft_picks

  has_many :games,
    through: :contest

  def self.for_user(user)
    where(user: user)
  end

  def score
    Stat.where(player: players, game: games).sum(:points)
  end
end
