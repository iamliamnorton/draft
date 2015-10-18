require 'csv'

namespace :import do
  desc "import NBA schedule"
  task nba_games: :environment do
    nba = Sport.where(name: "NBA").first_or_create!

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
        team = Team.where(name: team_name, sport: nba).first_or_create!
        game = Game.where(
          sport: nba,
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
  task nba_players: :environment do
    nba = Sport.where(name: "NBA").first_or_create!

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
      player = Player.where(source_id: row['Rk'], name: row['Player']).first_or_initialize
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
        team = Team.where(name: team_mapper.fetch(row['Tm']), sport: nba).first_or_create!
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
