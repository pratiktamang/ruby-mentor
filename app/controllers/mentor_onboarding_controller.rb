class MentorOnboardingController < ApplicationController
  before_action :authenticate_mentor!
  before_action :set_mentor

  def new
    @mentor_profile = @mentor.build_mentor_profile
  end

  def create
    mentor_attrs = mentor_onboarding_params.slice(:mentor_attributes)
    @mentor.update(mentor_attrs[:mentor_attributes])

    profile_params = mentor_onboarding_params.except(:mentor_attributes)
    @mentor_profile = @mentor.build_mentor_profile(profile_params)

    if @mentor_profile.save
      @mentor.update_attribute(:onboarded, true)
      redirect_to mentors_dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_mentor
    @mentor = Mentor.find(params[:mentor_id])
  end

  def mentor_onboarding_params
    params.require(:mentor_profile).permit(
      :company_url,
      :ruby_start_year,
      :country,
      :city,
      :twitter,
      :github,
      :personal_site,
      :past_workplaces,
      :previous_mentoring,
      :motivation,
      :communication_preference,
      :industry_expertise,
      :specific_interests,
      mentor_attributes: [:id, :first_name, :last_name],
      availability: []
    )
  end
end
