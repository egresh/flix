FactoryBot.define do
  factory :movie do
    title { "The Big Lebowski" }
    total_gross { 500_000_000 }
    rating { "R" }
    description { "The dude and friends solve a caper" }
    released_on { 25.years.ago }
    director { "The Coen Brothers" }
    duration { "2 hours" }
  end
end
