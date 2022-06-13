FactoryBot.define do
  factory :user do
    name { "John Smith" }
    sequence(:email) { |n| "jsmith#{n}@example.com" }
    sequence(:username) { |n| "jsmith#{n}" }
    password { "secret" }
    password_confirmation { "secret" }
    admin { false }
  end
end


