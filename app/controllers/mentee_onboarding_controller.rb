class MenteeOnboardingController < ApplicationController
  before_action :authenticate_mentee!
  before_action :set_mentee

  def new
    @mentee_profile = MenteeProfile.new
  end

  def create
    @mentee_profile = @mentee.build_mentee_profile(mentee_params)
    if @mentee_profile.save
      @mentee.update_attribute(:onboarded, true)
      redirect_to mentees_dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_mentee
    @mentee = Mentee.find(params[:mentee_id])
  end

  def mentee_params
    params.require(:mentee_profile).permit(
      :country,
      :city,
      :workplace_url,
      :writing_ruby,
      :start_source,
      :start_detail,
      :underrepresented_group,
      :twitter,
      :github,
      :personal_site,
      :other_languages,
      :past_career,
      :mentoring_goals,
      :mentee_id
    )
  end
end
