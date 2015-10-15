FactoryGirl.define do
  factory :contest_entry_form do
    user
    contest

    initialize_with { new(attributes) }
  end
end
