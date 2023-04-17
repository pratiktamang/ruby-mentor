class Mentees::DashboardController < ApplicationController
  before_action :authenticate_mentee!
  before_action :ensure_onboarded

  def index
    @mentee = current_mentee
  end

  private

  def ensure_onboarded
    redirect_to new_mentee_onboarding_path(current_mentee) unless current_mentee.onboarded
  end
end
