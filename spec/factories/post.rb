FactoryBot.define do
  factory :list do
    title {Faker::Lorem.characters(number:10)}
    description  {Faker::Lorem.characters(number:30)}
  end
end