FactoryGirl.define do
  factory :round do
    name "Tuesday 14/2"
    sport
    opened_at { 2.minutes.ago }
    closed_at { 5.minutes.from_now }

    factory :pending_round do
      opened_at { 6.minutes.from_now }
      closed_at { 11.minutes.from_now }
    end

    factory :closed_round do
      opened_at { 15.minutes.ago }
      closed_at { 2.minutes.ago }
    end
  end
end
