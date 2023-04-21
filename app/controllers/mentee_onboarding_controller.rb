class MenteeOnboardingController < ApplicationController
  before_action :authenticate_mentee!
  before_action :set_mentee

  def new
    @mentee_profile = @mentee.build_mentee_profile
  end

  def create
    mentee_attrs = mentee_onboarding_params.slice(:mentee_attributes)
    @mentee.update(mentee_attrs[:mentee_attributes])

    profile_params = mentee_onboarding_params.except(:mentee_attributes)
    @mentee_profile = @mentee.build_mentee_profile(profile_params)

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

  def mentee_onboarding_params
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
      :communication_preference,
      :desired_industry,
      :specific_interests,
      mentee_attributes: [:id, :first_name, :last_name],
      availability: []
    )
  end
end
