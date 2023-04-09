FactoryBot.define do
  factory :project do
    title { "MyString" }
    description { "MyText" }
    status { "MyString" }
    mentee { nil }
    mentor { nil }
  end
end
