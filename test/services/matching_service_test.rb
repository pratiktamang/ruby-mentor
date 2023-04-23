require "test_helper"

class MatchingServiceTest < ActiveSupport::TestCase
  setup do
    Rails.application.load_seed # Load the seed data
  end

  test "matching_service_assigns_all_mentees_to_mentors" do
    mentors = Mentor.available
    mentees = Mentee.all

    matching_service = MatchingService.new(mentors, mentees)
    matched_pairs = matching_service.perform

    matched_mentors = matched_pairs.map { |pair| pair[:mentor] }

    assert_equal mentors.count, matched_mentors.count, "Not all mentors were matched with a mentee."
    assert_equal matched_mentors.uniq.count, matched_mentors.count, "Some mentors were matched with multiple mentees."
  end

  test "matching service does not match the same mentor with multiple mentees" do
    mentors = Mentor.available
    mentees = Mentee.seeking_mentorship

    matching_service = MatchingService.new(mentors, mentees)
    matched_pairs = matching_service.perform

    matched_mentors = matched_pairs.map { |pair| pair[:mentor] }
    duplicated_mentors = matched_mentors.select { |mentor| matched_mentors.count(mentor) > 1 }

    assert_empty duplicated_mentors, "Some mentors were matched with multiple mentees"
  end
end
