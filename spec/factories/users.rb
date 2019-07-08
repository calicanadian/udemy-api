FactoryBot.define do
  factory :user do
    sequence(:login) { |n| "jsmith#{n}" }
    password { "secretpassword" }
    name { "John Smith" }
    url { "http://example.com" }
    avatar_url { "http://example.com/avatar" }
    provider { "github" }
  end
end
