FactoryBot.define do
  factory :match do
    association :fighter1, factory: :fighter
    association :fighter2, factory: :fighter
    duration { 120 }
    status { :pending }
    started_at { nil }
  end
end