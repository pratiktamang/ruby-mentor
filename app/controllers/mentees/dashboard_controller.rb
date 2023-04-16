class Mentees::DashboardController < ApplicationController
  before_action :authenticate_mentee!
  before_action :ensure_onboarding_completed

  def index
  end

  private

  def ensure_onboarding_completed
    redirect_to new_mentee_onboarding_path(current_mentee) unless current_mentee.onboarded
  end
end
