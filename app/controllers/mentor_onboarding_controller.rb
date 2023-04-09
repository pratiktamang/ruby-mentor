class MentorOnboardingController < ApplicationController
  before_action :authenticate_mentor!
  before_action :set_mentor

  def new
  end

  def create
  end

  private

  def set_mentor
    @mentor = Mentor.find(params[:mentor_id])
  end
end
