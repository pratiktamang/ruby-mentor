class Admins::MatchesController < ApplicationController
  before_action :authenticate_admin!

  def index
    mentors = Mentor.available
    mentees = Mentee.seeking_mentorship
    matching_service = MatchingService.new(mentors, mentees)
    @matched_pairs = matching_service.perform
  end
end
