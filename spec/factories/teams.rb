FactoryGirl.define do
  factory :team do
    season
    sequence(:name) { |n| "Team #{n}" }
  end
end
