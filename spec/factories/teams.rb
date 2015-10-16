FactoryGirl.define do
  factory :team do
    sport
    sequence(:name) { |n| "Team #{n}" }
  end
end
