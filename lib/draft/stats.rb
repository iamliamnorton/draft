module Draft
  class Stats
    def initialize(game:, player:)
      @game = game
      @player = player
    end

    def collect!
      stat = Stat.where(game: @game, player: @player).first_or_initialize
      stat.points += rand(0..10) # TODO get live stats
      stat.save!
    end
  end
end
