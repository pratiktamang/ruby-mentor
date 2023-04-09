class MenteeOnboardingController < ApplicationController
  before_action :authenticate_mentee!
  before_action :set_mentee

  def new
  end

  def create
  end

  private

  def set_mentee
    @mentee = Mentee.find(params[:mentee_id])
  end
end
