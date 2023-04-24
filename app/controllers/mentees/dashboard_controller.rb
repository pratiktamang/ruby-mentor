class Mentees::DashboardController < ApplicationController
  before_action :authenticate_mentee!
  before_action :ensure_onboarded

  def index
    @mentee = current_mentee
    @mentorship = Mentorship.find_by(mentee_id: @mentee.id)
    @mentor = @mentorship.present? ? Mentor.find(@mentorship.mentor_id) : nil
  end

  private

  def ensure_onboarded
    redirect_to new_mentee_onboarding_path(current_mentee) unless current_mentee.onboarded
  end
end
