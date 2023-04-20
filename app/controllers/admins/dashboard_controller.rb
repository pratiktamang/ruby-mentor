class Admins::DashboardController < ApplicationController
  before_action :authenticate_admin!

  def index
    @admin = current_admin
  end

  def run_match_service
    mentors = Mentor.available
    mentees = Mentee.seeking

    matcher = MentorMenteeMatcher.new(mentors, mentees)
    matches = matcher.match

    # Store matches in session or another temporary storage
    session[:matches] = matches.map { |m, n| {mentee_id: m.id, mentor_id: n.id} }

    redirect_to admin_matches_path
  end
end
