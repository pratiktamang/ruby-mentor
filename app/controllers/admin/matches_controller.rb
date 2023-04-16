class Admin::MatchesController < ApplicationController
  def index
    @matches = session[:matches] ? session[:matches].map { |m| {mentee: Mentee.find(m[:mentee_id]), mentor: Mentor.find(m[:mentor_id])} } : Match.all
  end

  def approve_matches
    if session[:matches]
      session[:matches].each do |match|
        mentor = Mentor.find(match[:mentor_id])
        mentee = Mentee.find(match[:mentee_id])
        Match.create(mentor: mentor, mentee: mentee)
        # Send notifications to mentors and mentees
      end
      session.delete(:matches)
    end
    redirect_to admin_matches_path, notice: "Matches approved and saved!"
  end
end
