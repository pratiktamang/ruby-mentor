FactoryBot.define do
  factory :mentor_profile do
    mentor { nil }
    company_url { "MyString" }
    ruby_start_year { 1 }
    country { "MyString" }
    city { "MyString" }
    twitter { "MyString" }
    github { "MyString" }
    personal_site { "MyString" }
    past_workplaces { "MyText" }
    previous_mentoring { false }
    motivation { "MyText" }
  end
end
