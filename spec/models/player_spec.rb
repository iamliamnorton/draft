require 'rails_helper'

RSpec.describe Player, type: :model do
  describe "#valid?" do
    it { is_expected.to \
         validate_presence_of(:name) }

    it { is_expected.to \
         validate_presence_of(:position) }

    it { is_expected.to \
         validate_presence_of(:salary) }

    it "factory is valid" do
      player = create(:player)

      expect(player.valid?).to eq(true)
    end
  end

  describe ".for_round" do
    it "returns players available in round" do
      create(:player)

      team = create(:team)
      round = create(:round)

      contest = create(:contest, round: round)
      game = create(:game, team: team, round: round)

      available_player = create(:player, team: team)

      aggregate_failures do
        expect(Player.for_round(round)).to include(available_player)
        expect(Player.for_round(round).count).to eq(1)
      end
    end
  end
end
