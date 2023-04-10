FactoryBot.define do
  factory :mentee_profile do
    mentee { nil }
    country { "MyString" }
    city { "MyString" }
    workplace_url { "MyString" }
    writing_ruby { false }
    start_source { "MyString" }
    underrepresented_group { false }
    twitter { "MyString" }
    github { "MyString" }
    personal_site { "MyString" }
    other_languages { "MyString" }
    past_career { "MyString" }
    mentoring_goals { "MyText" }
  end
end
