FactoryGirl.define do
  factory :contest do
    user
    entry 1_00
    cap 60_000
    min_entries 2
    max_entries 100

    factory :closed_contest do
      closed_at { 2.minutes.ago }
    end

    factory :started_contest do
      started_at { 2.minutes.ago }
    end

    factory :won_contest do
      won_at { 2.minutes.ago }
    end
  end
end
