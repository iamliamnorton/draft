FactoryGirl.define do
  factory :contest do
    user
    round
    entry 1_00
    cap 60_000
    min_entries 1
    max_entries 5

    factory :settled_contest do
      settled_at { 2.minutes.ago }
    end
  end
end
