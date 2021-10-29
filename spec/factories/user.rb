FactoryBot.define do
  factory :user do
    name                        {"facotrybot"}
    email                       {"factorybotmail@gmail.com"}
    encrypted_password          {"12345678"}
    password_confirmation       {"12345678"}
  end
end