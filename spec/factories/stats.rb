FactoryGirl.define do
  factory :stat do
    points 120
    player
    game

    factory :completed_stat do
      completed_at 2.minutes.ago
    end
  end
end
