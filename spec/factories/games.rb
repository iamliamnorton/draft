FactoryGirl.define do
  factory :game do
    season
    round
    association :home_team, factory: :team
    association :away_team, factory: :team
    started_at { 7.hours.from_now }

    factory :running_game do
      started_at { 2.minutes.ago }
    end

    factory :completed_game do
      completed_at { 2.minutes.ago }
    end
  end
end
