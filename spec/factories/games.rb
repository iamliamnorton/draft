FactoryGirl.define do
  factory :game do
    home_team
    away_team
    started_at { 1.day.from_now }
  end
end
