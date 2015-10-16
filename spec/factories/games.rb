FactoryGirl.define do
  factory :game do
    home_team { create(:team) }
    away_team { create(:team) }
    started_at { 1.day.from_now }
  end
end
