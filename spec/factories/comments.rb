FactoryBot.define do
  factory :comment do
    content { "My awesome comment for article" }
    association :article
    association :user
  end
end
