abort("The Rails environment is running in production mode!") if Rails.env.production?

ActiveRecord::Base.transaction do
  User.destroy_all
  User.create!(
    email: "bob@email.com",
    password: "asdfasdf",
    password_confirmation: "asdfasdf",
    credit: 100_00,
    confirmed_at: Time.now
  )
  User.create!(
    email: "foo@email.com",
    password: "asdfasdf",
    password_confirmation: "asdfasdf",
    confirmed_at: Time.now
  )
end
