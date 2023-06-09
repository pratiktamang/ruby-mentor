class Mentors::DashboardController < ApplicationController
  before_action :authenticate_mentor!
  before_action :ensure_onboarded

  def index
    @mentor = current_mentor
  end

  private

  def ensure_onboarded
    redirect_to new_mentor_onboarding_path(current_mentor) unless current_mentor.onboarded?
  end
end
