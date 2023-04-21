class MentorOnboardingController < ApplicationController
  before_action :authenticate_mentor!
  before_action :set_mentor

  def new
    @mentor_profile = MentorProfile.new
  end

  def create
    @mentor_profile = @mentor.build_mentor_profile(mentor_params)
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

  def mentor_params
    params.require(:mentor_profile).permit(
      :mentor_id,
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
      :availability,
      :industry_expertise,
      :specific_interests,
      availability: []
    )
  end
end
