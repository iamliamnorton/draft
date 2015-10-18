FactoryGirl.define do
  factory :round do
    name "Tuesday 14/2"
    opened_at { 2.hours.ago }
    closed_at { 6.hours.from_now }

    factory :closed_round do
      opened_at { 4.minutes.ago }
      closed_at { 3.minutes.ago }
    end

    factory :completed_round do
      opened_at { 5.minutes.ago }
      closed_at { 4.minutes.ago }
      completed_at { 3.minutes.ago }
    end
  end
end
