FactoryBot.define do
  factory :account do
    sequence(:username) { |n| "username_#{n}" }
    sequence(:email) { |n| "test_#{n}@example.com" }
    avatar_url { "https://example.com/text.png" }
    password_digest { "password" }
  end
end
