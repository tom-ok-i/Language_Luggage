FactoryBot.define do
  factory :post do
    title {Faker::Lorem.characters(number:10)}
    description  {Faker::Lorem.characters(number:30)}
    user_id {"2"}
    genre_id {"3"}
  end
end