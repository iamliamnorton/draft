FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@email.com" }
    password "password"
    password_confirmation "password"
    confirmed_at Time.now

    factory :admin_user do
      admin true
    end
  end
end
