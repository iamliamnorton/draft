class CollectStatsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    Game.include_players.running.each do |game|
      players = [
	game.home_team.players.all,
	game.away_team.players.all
      ].flatten

      players.each do |player|
	Draft::Stats.for(game: game, player: player).collect!
      end
    end
  end
end
