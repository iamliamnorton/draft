require 'csv'

namespace :import do
  desc "import NBA player and team data"
  task nba: :environment do
    csv_text = File.read('data/nba/players.csv')
    csv = CSV.parse(csv_text, :headers => true)

    nba = Sport.where(name: "NBA").first_or_create

    csv.each do |row|

      unless row['Tm'] == "TOT"
        team = Team.where(name: row['Tm'], sport: nba).first_or_create!
      end

      player = Player.where(source_id: row['Rk'], name: row['Player']).first_or_initialize

      player.position = row['Pos']

      unless row['Tm'] == "TOT"
        player.team = team
      end

      # Fantasy point calc # TODO
      #
      points = row['PTS'].to_f
      assists = 1.5 * row['AST'].to_f
      rebounds = 1.2 * row['TRB'].to_f
      blocks = 2.0 * row['BLK'].to_f
      steals = 2.0 * row['STL'].to_f
      turnovers = row['TOV'].to_f

      production = points + assists + rebounds + blocks + steals - turnovers
      fantasy_points = (production * 200).to_i.round(-2)

      player.salary = [fantasy_points, 100].max

      player.save!
    end
  end

  desc "import NBA schedule"
  task nba: :environment do
    csv_text = File.read('data/nba/schedule.csv')
    csv = CSV.parse(csv_text, :headers => true)

    nba = Sport.where(name: "NBA").first_or_create

    mapper = {
      "Atlanta Hawks" => "ATL",
      "Boston Celtics" => "BOS",
      "Brooklyn Nets" => "BRK",
      "Charlotte Hornets" => "CHA",
      "Chicago Bulls" => "CHI",
      "Cleveland Cavaliers" => "ClE",
      "Dallas Mavericks" => "DAL",
      "Denver Nuggets" => "DEN",
      "Detroit Pistons" => "DET",
      "Golden State Warriors" => "GSW",
      "Houston Rockets" => "HOU",
      "Indiana Pacers" => "IND",
      "Los Angeles Clippers" => "LAC",
      "Los Angeles Lakers" => "LAL",
      "Memphis Grizzlies" => "MEM",
      "Miami Heat" => "MIA",
      "Milwaukee Bucks" => "MIL",
      "Minnesota Timberwolves" => "MIN",
      "New Orleans Pelicans" => "NOP",
      "New York Knicks" => "NYK",
      "Oklahoma City Thunder" => "OKC",
      "Orlando Magic" => "ORL",
      "Philadelphia 76ers" => "PHI",
      "Phoenix Suns" => "PHO",
      "Portland Trail Blazers" => "POR",
      "Sacramento Kings" => "SAC",
      "San Antonio Spurs" => "SAN",
      "Toronto Raptors" => "TOR",
      "Utah Jazz" => "UTH",
      "Washington Wizards" => "WAS",
    }

    nba = Sport.where(name: "NBA").first_or_create

    csv.each do |row|
      # create a game (without a round)
      # for both home and away teams
      #

      home_team = mapper.fetch(row['Home/Neutral'])

      game = Game.where(
        team: home_team,
        started_at: Time.parse("#{row['Date']} #{row['Start (ED)']} EDT"),
        sport: nba
      )
    end
  end
end
