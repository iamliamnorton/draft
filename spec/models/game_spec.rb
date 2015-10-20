require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "#valid?" do
    it "factory is valid" do
      game = create(:game)

      expect(game.valid?).to eq(true)
    end
  end

  describe ".incomplete" do
    it "returns incomplete games" do
      completed_game = create(:completed_game)

      create(:game)
      create(:running_game)

      aggregate_failures do
        expect(Game.incomplete).not_to include(completed_game)
        expect(Game.incomplete.count).to eq(2)
      end
    end
  end

  describe ".running" do
    it "returns running games" do
      running_game = create(:running_game)

      create(:game)
      create(:completed_game)

      aggregate_failures do
        expect(Game.running).to include(running_game)
        expect(Game.running.count).to eq(1)
      end
    end
  end
end
