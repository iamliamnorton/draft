require 'rails_helper'

RSpec.describe Draft::Stats, type: :model do
  describe "#collect!" do
    it "creates or updates the stats" do
      game = create(:running_game)
      player = create(:player, team: game.home_team)

      Draft::Stats.for(game: game, player: player).collect!

      expect(Stat.count).to eq(1)
    end
  end
end
