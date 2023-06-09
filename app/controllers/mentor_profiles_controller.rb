class MentorProfilesController < ApplicationController
  before_action :authenticate_mentor!

  def edit
    @mentor = Mentor.find(params[:id])
    @mentor_profile = @mentor.mentor_profile
  end

  def update
    @mentor = Mentor.find(params[:id])
    @mentor_profile = @mentor.mentor_profile

    if params[:mentor_profile][:availability].nil?
      redirect_to edit_mentor_profile_path(@mentor), notice: "Availability must be selected."
    elsif @mentor_profile.update(mentor_profile_params)
      redirect_to edit_mentor_profile_path(@mentor), notice: "Your profile was updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def mentor_profile_params
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
      :learning_preferences,
      :industry_expertise,
      :specific_interests,
      availability: [],
      mentor_attributes: [:id, :first_name, :last_name]
    )
  end
end
