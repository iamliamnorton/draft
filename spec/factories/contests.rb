FactoryGirl.define do
  factory :contest do
    entry 1_00
    cap Contest::DEFAULT_CAP

    factory :contest_closed do
      closed_at { 2.minutes.ago }
    end

    factory :contest_cancelled do
      cancelled_at { 2.minutes.ago }
    end

    factory :contest_won do
      won_at { 2.minutes.ago }
    end
  end
end
