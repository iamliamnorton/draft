require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "#valid?" do
    it "factory is valid" do
      game = create(:game)

      expect(game.valid?).to eq(true)
    end
  end
end
