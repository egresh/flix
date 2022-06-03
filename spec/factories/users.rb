FactoryBot.define do
  factory :user do
    name { "John Smith" }
    email { "jsmith@example.com" }
    password { "secret" }
    password_confirmation { "secret" }
  end
end
