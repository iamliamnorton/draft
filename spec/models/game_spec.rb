require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "#valid?" do
    it { is_expected.to \
         validate_presence_of(:away_team_id) }

    it { is_expected.to \
         validate_presence_of(:home_team_id) }

    it "factory is valid" do
      game = create(:game)

      expect(game.valid?).to eq(true)
    end
  end
end
