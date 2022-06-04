FactoryBot.define do
  factory :user do
    name { "John Smith" }
    sequence(:email) { |n| "jsmith#{n}@example.com" }
    password { "secret" }
    password_confirmation { "secret" }
  end
end
