class MenteesController < ApplicationController
  before_action :authenticate_mentee!
  before_action :set_mentee
  before_action :ensure_onboarding_completed

  def show
  end

  private

  def set_mentee
    @mentee = Mentee.find(params[:id])
  end

  def ensure_onboarding_completed
    redirect_to new_mentee_mentee_onboarding_path(@mentee) unless @mentee.onboarded
  end
end
