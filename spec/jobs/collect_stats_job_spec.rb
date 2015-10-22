require 'rails_helper'

RSpec.describe CollectStatsJob, type: :job do
  it "calls for game stats to be collected for running games" do
    unstarted_game = create(:game)
    running_game = create(:running_game)
    completed_game = create(:completed_game)

    inactive_player = create(:player, team: unstarted_game.home_team)
    active_player = create(:player, team: running_game.home_team)
    old_player = create(:player, team: completed_game.home_team)

    stats_collector = instance_double(Draft::Stats)

    allow(Draft::Stats).
      to receive(:new).
      with(game: running_game, player: active_player).
      and_return(stats_collector)

    expect(stats_collector).to receive(:collect!)

    CollectStatsJob.new.perform
  end
end
