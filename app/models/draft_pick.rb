class DraftPick < ActiveRecord::Base
  belongs_to :roster

  belongs_to :player

  validates :cost,
    presence: true

  def self.for_player(player)
    where(player: player)
  end
end
