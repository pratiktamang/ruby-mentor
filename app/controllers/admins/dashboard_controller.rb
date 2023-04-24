class Admins::DashboardController < ApplicationController
  before_action :authenticate_admin!

  def index
    @admin = current_admin
  end

  def run_match_service
    mentors = Mentor.available
    mentees = Mentee.all

    matching_service = MatchingService.new(mentors, mentees)
    matching_service.perform
    render json: {success: true}
  end
end
