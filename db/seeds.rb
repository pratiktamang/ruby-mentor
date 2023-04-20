def seed_mentor
  mentor = Mentor.new do |m|
    m.first_name = "Awesome"
    m.last_name = "Mentor"
    m.password = "password"
    m.email = "pratik+mentor@example.com"
    m.password_confirmation = "password"
    m.onboarded = false
  end

  mentor.save!
end

def seed_mentee
  mentee = Mentee.new do |m|
    m.first_name = "Awesome"
    m.last_name = "Mentee"
    m.password = "password"
    m.email = "pratik+mentee@example.com"
    m.password_confirmation = "password"
    m.onboarded = false
  end

  mentee.save!
end

def seed_admin
  admin = Admin.new do |a|
    a.email = "pratik+admin@example.com"
    a.password = "password"
    a.password_confirmation = "password"
  end

  admin.save!
end

def seed_onboarded_mentees
  25.times do |m|
    mentee = Mentee.new do |m|
      m.first_name = Faker::Name.first_name
      m.last_name = Faker::Name.last_name
      m.password = "password"
      m.email = Faker::Internet.email
      m.password_confirmation = "password"
      m.onboarded = true
    end

    mentee.save!
  end
end

def seed_onboarded_mentors
  25.times do |m|
    mentor = Mentor.new do |m|
      m.first_name = Faker::Name.first_name
      m.last_name = Faker::Name.last_name
      m.password = "password"
      m.email = Faker::Internet.email
      m.password_confirmation = "password"
      m.onboarded = true
    end

    mentor.save!
  end
end

def seed_mentor_profiles
  mentors = Mentor.all

  years = [1990, 1994, 1995, 1998, 2002, 2003, 2004, 2008, 2012, 2020]
  mentors.each do |mentor|
    mentor.create_mentor_profile(
      ruby_start_year: years.sample.to_s,
      country: Faker::Address.country,
      city: Faker::Address.city,
      twitter: Faker::Internet.user_name,
      github: Faker::Internet.user_name,
      personal_site: Faker::Internet.url,
      past_workplaces: Faker::Lorem.sentence,
      previous_mentoring: [true, false].sample,
      motivation: Faker::Lorem.sentence,
      company_url: Faker::Internet.url
    )
  end
end

def seed_mentee_profiles
  mentees = Mentee.all

  mentees.each do |mentee|
    mentee.create_mentee_profile(
      country: Faker::Address.country,
      city: Faker::Address.city,
      workplace_url: Faker::Internet.url,
      writing_ruby: [true, false].sample,
      start_source: Faker::Lorem.sentence,
      underrepresented_group: Faker::Lorem.sentence,
      twitter: Faker::Internet.user_name,
      github: Faker::Internet.user_name,
      personal_site: Faker::Internet.url,
      other_languages: Faker::Lorem.sentence,
      past_career: Faker::Lorem.sentence,
      mentoring_goals: Faker::Lorem.sentence
    )
  end
end

def elapsed = Benchmark.measure do
  puts "Seeding development database..."
  seed_mentor
  seed_mentee
  seed_admin
  seed_onboarded_mentees
  seed_onboarded_mentors
  seed_mentor_profiles
  seed_mentee_profiles
end

puts "Seeded development DB in #{elapsed.real} seconds"
