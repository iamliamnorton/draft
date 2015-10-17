FactoryGirl.define do
  factory :game do
    sport
    round
    team
    started_at { 7.hours.from_now }
  end
end
