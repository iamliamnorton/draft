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
