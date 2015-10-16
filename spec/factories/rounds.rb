FactoryGirl.define do
  factory :round do
    name "Tuesday 14/2"
    opened_at { 2.hours.ago }
    closed_at { 6.hours.from_now }
    completed_at { 9.hours.from_now }

    factory :pending_round do
      opened_at { 3.minutes.from_now }
    end

    factory :closed_round do
      closed_at { 3.minutes.ago }
    end

    factory :completed_round do
      completed_at { 3.minutes.ago }
    end
  end
end
