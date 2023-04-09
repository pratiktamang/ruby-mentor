FactoryBot.define do
  factory :mentor_profile do
    mentor { nil }
    country { "MyString" }
    city { "MyString" }
    workplace_url { "MyString" }
    writing_ruby { false }
    start_source { "MyString" }
    start_detail { "MyString" }
    underrepresented_group { false }
    twitter { "MyString" }
    github { "MyString" }
    personal_site { "MyString" }
    other_languages { "MyString" }
    past_career { "MyString" }
    mentoring_goals { "MyText" }
  end
end
