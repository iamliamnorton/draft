abort("The Rails environment is running in production mode!") if Rails.env.production?

User.destroy_all
User.create!(
  email: "bob@email.com",
  password: "asdfasdf",
  password_confirmation: "asdfasdf",
  confirmed_at: Time.now
)
