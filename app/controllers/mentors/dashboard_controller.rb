class Mentors::DashboardController < ApplicationController
  before_action :authenticate_mentor!
  before_action :ensure_onboarded, only: [:index]

  def index
  end

  private

  def ensure_onboarded
    puts "current_mentor: #{current_mentor.inspect}"
    redirect_to new_mentor_onboarding_path(current_mentor) unless current_mentor.onboarded?
  end
end
