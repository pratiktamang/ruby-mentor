class Admins::MatchesController < ApplicationController
  def index
    mentors = Mentor.available
    mentees = Mentee.seeking_mentorship
    matching_service = MatchingService.new(mentors, mentees)
    @matched_pairs = matching_service.perform
  end
end
