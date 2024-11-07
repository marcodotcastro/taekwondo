FactoryBot.define do
  factory :fighter do
    sequence(:name) { |n| "Fighter #{n}" }
    category { "Peso Médio" }
    weight { 75 }
  end
end