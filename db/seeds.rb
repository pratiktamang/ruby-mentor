def seed_default_mentor
  mentor = Mentor.new do |m|
    m.first_name = "Awesome"
    m.last_name = "Mentor"
    m.password = "password"
    m.email = "pratik+mentor@example.com"
    m.password_confirmation = "password"
    m.onboarded = true
    m.available = true
  end

  mentor.save!
end

def seed_default_mentee
  mentee = Mentee.new do |m|
    m.first_name = "Awesome"
    m.last_name = "Mentee"
    m.password = "password"
    m.email = "pratik+mentee@example.com"
    m.password_confirmation = "password"
    m.onboarded = true
    m.seeking_mentorhip = true
  end

  mentee.save!
end

def seed_default_admin
  admin = Admin.new do |a|
    a.email = "pratik+admin@example.com"
    a.password = "password"
    a.password_confirmation = "password"
  end

  admin.save!
end

def seed_onboarded_mentees
  50.times do |m|
    mentee = Mentee.new do |m|
      m.first_name = Faker::Name.first_name
      m.last_name = Faker::Name.last_name
      m.password = "password"
      m.email = Faker::Internet.email
      m.password_confirmation = "password"
      m.onboarded = true
      m.seeking_mentorhip = true
    end

    mentee.save!
  end
end

def seed_onboarded_mentors
  50.times do |m|
    mentor = Mentor.new do |m|
      m.first_name = Faker::Name.first_name
      m.last_name = Faker::Name.last_name
      m.password = "password"
      m.email = Faker::Internet.email
      m.password_confirmation = "password"
      m.onboarded = true
      m.available = true
    end

    mentor.save!
  end
end

def common_profile_attributes
  learning_preferences = ["visual", "auditory", "kinesthetic", "social", "reading", "solitary"]
  days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
  countries = ["UK", "USA", "France", "Brazil", "Ukraine", "Poland", "Japan"]
  areas = ["rails", "web-dev", "dev ops", "machine learning"]
  languages = ["English", "French", "Spanish", "German", "Russian", "Japanese", "Chinese"]

  {
    country: countries.sample,
    city: Faker::Address.city,
    twitter: Faker::Internet.user_name,
    github: Faker::Internet.user_name,
    personal_site: Faker::Internet.url,
    learning_preferences: learning_preferences.sample,
    other_languages: languages.sample,
    availability: days.sample(rand(1..days.length)),
    specific_interests: areas.sample
  }
end

def seed_mentor_profiles
  mentors = Mentor.all
  years = [1990, 1994, 1995, 1998, 2002, 2003, 2004, 2008, 2012, 2020].map { |year| Date.new(year) }

  mentors.each do |mentor|
    mentor_profile = mentor.create_mentor_profile(
      common_profile_attributes.merge(
        company_url: Faker::Internet.url,
        ruby_start_year: years.sample,
        past_workplaces: Faker::Lorem.sentence,
        previous_mentoring: [true, false].sample,
        motivation: Faker::Lorem.sentence,
        industry_expertise: Faker::Lorem.sentence
      )
    )
    mentor_profile.save!
  end
end

def seed_mentee_profiles
  mentees = Mentee.all

  mentees.each do |mentee|
    mentee_profile = mentee.build_mentee_profile(
      common_profile_attributes.merge(
        workplace_url: Faker::Internet.url,
        writing_ruby: [true, false].sample,
        start_source: Faker::Lorem.sentence,
        underrepresented_group: Faker::Lorem.sentence,
        past_career: Faker::Lorem.sentence,
        mentoring_goals: Faker::Lorem.sentence,
        desired_industry: Faker::Lorem.sentence
      )
    )
    mentee_profile.save!
  end
end

def elapsed = Benchmark.measure do
  puts "Seeding development database..."
  seed_default_mentor
  seed_default_mentee
  seed_default_admin
  seed_onboarded_mentees
  seed_onboarded_mentors
  seed_mentor_profiles
  seed_mentee_profiles
end

puts "Seeded development DB in #{elapsed.real} seconds"
