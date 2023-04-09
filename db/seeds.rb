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

def elapsed = Benchmark.measure do
  puts "Seeding development database..."
  seed_mentor
  seed_mentee
end

puts "Seeded development DB in #{elapsed.real} seconds"
