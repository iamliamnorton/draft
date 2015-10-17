require 'rails_helper'

RSpec.describe DraftPick, type: :model do
  describe "#valid?" do
    it { is_expected.to \
         validate_presence_of(:cost) }

    it "factory is valid" do
      draft_pick = create(:draft_pick)

      expect(draft_pick.valid?).to eq(true)
    end
  end

  describe ".for_player" do
    it "returns player draft_picks" do
      create(:draft_pick)

      player = create(:player)
      draft_pick = create(:draft_pick, player: player)

      aggregate_failures do
        expect(DraftPick.for_player(player)).to include(draft_pick)
        expect(DraftPick.for_player(player).count).to eq(1)
      end
    end
  end
end
