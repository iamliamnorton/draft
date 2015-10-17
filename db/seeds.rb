abort("The Rails environment is running in production mode!") if Rails.env.production?

ActiveRecord::Base.transaction do
  User.destroy_all
  User.create!(
    email: "bob@email.com",
    password: "asdfasdf",
    password_confirmation: "asdfasdf",
    confirmed_at: Time.now
  )
  User.create!(
    email: "foo@email.com",
    password: "asdfasdf",
    password_confirmation: "asdfasdf",
    confirmed_at: Time.now
  )

  Sport.destroy_all
  nba = Sport.create!(
    name: "NBA"
  )

  Team.destroy_all
  ["GSW", "CLE", "NYK", "MEM", "OKC", "MIN", "DEN", "POR", "NOP", "PHI", "IND", "DAL", "MIA", "BRK", "SAS", "MIL", "DET", "ATL", "HOU", "CHI", "LAC", "PHO", "BOS", "WAS", "UTA", "SAC", "CHO", "LAL", "TOR", "ORL"].each do |name|
    Team.create!(
      sport: nba,
      name: name
    )
  end

  Round.destroy_all
  round_1 = Round.create!(
    name: "NBA Weekend (14/2)",
    opened_at: 2.minutes.ago,
    closed_at: 3.hours.from_now,
    completed_at: 4.days.from_now
  )

  Game.destroy_all
  ["GSW", "CLE", "NYK", "MEM", "OKC", "MIN", "DEN", "POR", "NOP", "PHI", "IND", "DAL", "MIA", "BRK", "SAS", "MIL", "DET", "ATL", "HOU", "CHI", "LAC", "PHO", "BOS", "WAS", "UTA", "SAC", "CHO", "LAL", "TOR", "ORL"].each do |name|
    Game.create!(
      round: round_1,
      team: Team.find_by_name(name),
      sport: nba,
      started_at: 1.day.from_now
    )
  end
end
