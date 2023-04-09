class MentorsController < ApplicationController
  before_action :authenticate_mentor!
  before_action :set_mentor
  before_action :ensure_onboarding_completed

  def show
  end

  private

  def set_mentor
    @mentor = Mentor.find(params[:id])
  end

  def ensure_onboarding_completed
    redirect_to new_mentor_mentor_onboarding_path(@mentor) unless @mentor.onboarded
  end
end
