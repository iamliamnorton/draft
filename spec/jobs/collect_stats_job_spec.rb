require 'rails_helper'

RSpec.describe CollectStatsJob, type: :job do
  it "calls for game stats to be collected for players" do
    game = create(:running_game)

    player = create(:player, team: game.home_team)

    stats_collector = instance_double(Draft::Stats)

    allow(Draft::Stats).
      to receive(:new).
      with(game: game, player: player).
      and_return(stats_collector)

    expect(stats_collector).to receive(:collect!)

    CollectStatsJob.new.perform
  end
end
