require 'rails_helper'

RSpec.describe Roster, type: :model do
  describe "#valid?" do
    it "factory is valid" do
      roster = create(:roster)

      expect(roster.valid?).to eq(true)
    end
  end

  describe ".for_user" do
    it "returns rosters for user" do
      create(:roster)

      user = create(:user)
      user_roster = create(:roster, user: user)

      aggregate_failures do
        expect(Roster.for_user(user)).to include(user_roster)
        expect(Roster.for_user(user).count).to eq(1)
      end
    end
  end

  describe "#score" do
    it "returns sum of stat points" do
      contest = create(:contest)
      game = create(:game, round: contest.round)

      player_1 = create(:player, team: game.home_team)
      player_2 = create(:player, team: game.away_team)

      create(:stat, player: player_1, game: game, points: 100)
      create(:stat, player: player_2, game: game, points: 100)

      roster = create(:roster, contest: contest)
      create(:draft_pick, roster: roster, player: player_1)

      expect(roster.score).to eq(100)
    end

    it "returns 0 with no stats" do
      contest = create(:contest)
      game = create(:game, round: contest.round)

      player_1 = create(:player, team: game.home_team)
      player_2 = create(:player, team: game.away_team)

      create(:stat, player: player_1, game: game, points: 100)
      create(:stat, player: player_2, game: game, points: 100)

      roster = create(:roster, contest: contest)

      expect(roster.score).to eq(0)
    end
  end
end
