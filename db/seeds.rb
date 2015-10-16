abort("The Rails environment is running in production mode!") if Rails.env.production?

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

Round.destroy_all
Round.create!(
  sport: nba,
  name: "Tuesday 14/2",
  opened_at: 2.minutes.ago,
  closed_at: 2.days.from_now
)

Team.destroy_all
bulls = Team.create!(
  sport: nba,
  name: "Chicago Bulls"
)
celtics = Team.create!(
  sport: nba,
  name: "Boston Celtics"
)

Player.destroy_all
[
  {name: "Michael Jordan", position: "G", salary: "7400"},
  {name: "Derrick Rose", position: "G", salary: "5100"},
  {name: "Jimmy Butler", position: "G", salary: "5300"},
  {name: "Kirk Hinrich", position: "G", salary: "3800"},
  {name: "Taj Gibson", position: "F", salary: "4300"},
  {name: "Scotty Pippen", position: "F", salary: "6200"},
  {name: "Pau Gasol", position: "F", salary: "6100"},
  {name: "Luc Longley", position: "C", salary: "2600"},
  {name: "Joakim Noah", position: "C", salary: "4500"},
].each do |player|
  Player.create!(
    team: bulls,
    position: player[:position],
    salary: player[:salary],
    name: player[:name]
  )
end

[
  {name: "Avery Bradley", position: "G", salary: "4900"},
  {name: "Isaiah Thomas", position: "G", salary: "5400"},
  {name: "Marcus Smart", position: "G", salary: "3600"},
  {name: "Evan Turner", position: "G", salary: "4700"},
  {name: "Larry Bird", position: "F", salary: "6900"},
  {name: "David Lee", position: "F", salary: "4500"},
  {name: "Jared Sullinger", position: "F", salary: "4700"},
  {name: "Kelly Olynyk", position: "C", salary: "2600"},
  {name: "Robert Parish", position: "C", salary: "4600"},
].each do |player|
  Player.create!(
    team: celtics,
    position: player[:position],
    salary: player[:salary],
    name: player[:name]
  )
end
