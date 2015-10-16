FactoryGirl.define do
  factory :game do
    sport
    round
    team
    started_at { 1.day.from_now }
  end
end
