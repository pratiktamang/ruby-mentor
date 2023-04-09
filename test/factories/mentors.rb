FactoryBot.define do
  factory :mentor do
    first_name { "John" }
    last_name { "Doe" }
    email { "mentor@example.com" }
    password { "password" }
    password_confirmation { "password" }
    onboarded { false }

    trait :onboarded do
      onboarded { true }
    end
  end
end
