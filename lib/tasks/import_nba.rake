require 'csv'

namespace :import_nba do
  desc "import NBA teams"
  task proball_teams: :environment do
    nba = Season.where(name: "NBA", year: "2015", max_draft_picks: 10).first_or_create!

    puts "#{Team.count} Teams initially"

    team_data = Draft::ProBall.scrape_teams

    team_data.each do |data|
      team = Team.where(
        source_id: data["team_id"],
        name: data["team_name"],
        season: nba
      ).first_or_create!

      team.city = data["city"]
      team.abbreviation = data["abbreviation"]

      team.save!
    end

    puts "#{Team.count} Teams"
    puts "teams #{team_data.count}"
  end

  desc "import NBA games"
  task proball_games: :environment do
    nba = Season.where(name: "NBA", year: "2015", max_draft_picks: 10).first_or_create!

    puts "#{Game.count} Games initially"

    game_data = Draft::ProBall.scrape_games(season: 2014)

    rounds = []

    game_data.each do |data|
      data = data[1]

      game_started = Time.at(data['date']) + 6.months # TODO

      round = Round.where(
        name: "NBA #{game_started.day}/#{game_started.month}"
      ).first_or_create!

      round.opened_at = [ game_started - 3.days, round.opened_at ].compact.min - 3.days
      round.closed_at = [ game_started, round.closed_at ].compact.min
      round.save!

      rounds << round
      rounds.uniq!

      home_team = Team.find_by_source_id!(data['home_id'])
      away_team = Team.find_by_source_id!(data['away_id'])

      game = Game.where(
        home_team: home_team,
        away_team: away_team,
        season: nba,
        round: round
      ).first_or_create!

      game.source_id = data["game_id"]
      game.started_at = game_started
      game.save!
    end

    ended_games = Game.incomplete.where('started_at < ?', Time.now)
    puts "closing #{ended_games.count} games"
    ended_games.update_all(completed_at: Time.now)

    puts "Games processed #{game_data.count}"
    puts "#{rounds.count} Rounds processed (total: #{Round.count})"
    puts "#{Game.count} total Games"
  end

  desc "import NBA players"
  task proball_players: :environment do
    nba = Season.where(name: "NBA", year: "2015", max_draft_picks: 10).first_or_create!

    puts "#{Player.count} Players"

    player_data = Draft::ProBall.scrape_players

    player_data.each do |data|
      player = Player.
        where(source_id: data["player_id"], name: data["player_name"]).
        first_or_create!

      rand_id = Team.pluck(:id).sample
      player.team = Team.find(rand_id)

      # TODO team assoication broken for ProBall
      # player.team = Draft::ProBall::TEAM_MAPPER.fetch(data["team_id"])
      # player.team = Team.find_by_source!(data["team_id"])

      # TODO player position mapping
      player.position = data["position"]

      # TODO player salary calculations
      player.salary = rand(1000..10000)

      player.save!
    end

    puts "#{Player.count} Players"
    puts "players #{player_data.count}"
  end

  ### Csv source

  desc "import NBA schedule"
  task csv_games: :environment do
    nba = Season.where(name: "NBA", year: "2015", max_draft_picks: 10).first_or_create!

    csv_text = File.read('data/nba/schedule_2014_15.csv')
    csv = CSV.parse(csv_text, :headers => true)

    TIME_TRAVEL = 5.months # TODO remove this
    imported_games = 0
    rounds = []

    puts "Importing games..."

    csv.each do |row|
      game_start_at = Time.parse("#{row['Date']} #{row['Start (ET)']} EDT") + TIME_TRAVEL

      # TODO make rounds available between end of game and midnight
      round = Round.where(name: "NBA #{row['Date']}").first_or_create!
      round.opened_at = [
        game_start_at,
        round.opened_at
      ].compact.min + TIME_TRAVEL

      round.closed_at = [game_start_at, round.opened_at].compact.min + TIME_TRAVEL
      round.save!

      rounds << round

      home_team = row['Home/Neutral']
      away_team = row['Visitor/Neutral']

      [home_team, away_team].each do |team_name|
        team = Team.where(name: team_name, season: nba).first_or_create!
        game = Game.where(
          season: nba,
          round: round,
          team: team,
          started_at: (game_start_at + TIME_TRAVEL)
        ).first_or_create!

      end

      imported_games += 1
      rounds = rounds.uniq
    end

    puts "Updating round opening time on #{rounds.count} rounds..."

    rounds.each do |round|
      round.opened_at = round.opened_at - 3.days
      round.save!
    end

    puts "Imported #{imported_games} games (#{rounds.count} rounds)."
  end

  desc "import NBA player and team data"
  task csv_players: :environment do
    nba = Season.where(name: "NBA", year: "2015", max_draft_picks: 10).first_or_create!

    team_mapper = {
      "ATL" => "Atlanta Hawks",
      "BOS" => "Boston Celtics",
      "BRK" => "Brooklyn Nets",
      "CHO" => "Charlotte Hornets",
      "CHI" => "Chicago Bulls",
      "CLE" => "Cleveland Cavaliers",
      "DAL" => "Dallas Mavericks",
      "DEN" => "Denver Nuggets",
      "DET" => "Detroit Pistons",
      "GSW" => "Golden State Warriors",
      "HOU" => "Houston Rockets",
      "IND" => "Indiana Pacers",
      "LAC" => "Los Angeles Clippers",
      "LAL" => "Los Angeles Lakers",
      "MEM" => "Memphis Grizzlies",
      "MIA" => "Miami Heat",
      "MIL" => "Milwaukee Bucks",
      "MIN" => "Minnesota Timberwolves",
      "NOP" => "New Orleans Pelicans",
      "NYK" => "New York Knicks",
      "OKC" => "Oklahoma City Thunder",
      "ORL" => "Orlando Magic",
      "PHI" => "Philadelphia 76ers",
      "PHO" => "Phoenix Suns",
      "POR" => "Portland Trail Blazers",
      "SAC" => "Sacramento Kings",
      "SAS" => "San Antonio Spurs",
      "TOR" => "Toronto Raptors",
      "UTA" => "Utah Jazz",
      "WAS" => "Washington Wizards"
    }

    csv_text = File.read('data/nba/players.csv')
    csv = CSV.parse(csv_text, :headers => true)

    imported_players = 0
    traded_players = []

    puts "Importing players..."

    csv.each do |row|
      player = Player.
        where(source_id: row['Rk'], name: row['Player']).
        first_or_initialize

      player.position = row['Pos']

      # TODO extract fantasy point calc
      points = row['PTS'].to_f
      assists = 1.5 * row['AST'].to_f
      rebounds = 1.2 * row['TRB'].to_f
      blocks = 2.0 * row['BLK'].to_f
      steals = 2.0 * row['STL'].to_f
      turnovers = row['TOV'].to_f

      production = points + assists + rebounds + blocks + steals - turnovers
      fantasy_points = (production * 200).to_i.round(-2)

      if row['Tm'] == "TOT" # traded player season totals
        traded_players << [row['Rk']]

        player.salary = [fantasy_points, 100].max
      else
        team = Team.where(name: team_mapper.fetch(row['Tm']), season: nba).first_or_create!
        player.team = team

        unless traded_players.include?(row['Rk'])
          player.salary = [fantasy_points, 100].max
        end
      end

      player.save!

      imported_players += 1 unless traded_players.include?(row['Rk'])
    end

    puts "Imported #{imported_players} players."
  end
end
