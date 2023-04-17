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
    a.first_name = "Admin"
    a.last_name = "User"
    a.email = "pratik+admin@example.com"
    a.password = "password"
    m.password_confirmation = "password"
  end

  admin.save!
end

def seed_onboarded_mentees
  100.times do |m|
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
  100.times do |m|
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

  mentors.each do |mentor|
    mentor_profile = MentorProfile.new do |p|
      p.mentor = mentor
      p.company_url = Faker::Internet.url,
        p.ruby_start_year = rand(1990..2015),
        p.country = Faker::Address.country,
        p.city = Faker::Address.city,
        p.twitter = Faker::Internet.user_name,
        p.github = Faker::Internet.user_name,
        p.personal_site = Faker::Internet.url,
        p.past_workplaces = Faker::Lorem.paragraph(2),
        p.previous_mentoring = rand([true, false]),
        p.mentoring = Faker::Lorem.paragraph(2)
    end
    mentor_profile.save!
  end
end

def seed_mentee_profiles
  mentees = Mentee.all

  mentees.each do |mentee|
    mentee_profile = MenteeProfile.new do |p|
      p.country = Faker::Address.country,
        p.city = Faker::Address.city,
        p.workplace_url = Faker::Internet.url,
        p.writing_ruby = rand([true, false]),
        p.start_source = Faker::Lorem.paragraph(2),
        p.underrepresented_group = Faker::Lorem.paragraph(2),
        p.twitter = Faker::Internet.user_name,
        p.github = Faker::Internet.user_name,
        p.personal_site = Faker::Internet.url,
        p.other_languages = Faker::Lorem.paragraph(2),
        p.past_career = Faker::Lorem.paragraph(2),
        p.mentoring_goals = Faker::Lorem.paragraph(2)
    end
    mentee_profile.save!
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
