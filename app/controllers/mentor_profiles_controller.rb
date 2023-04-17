class MentorProfilesController < ApplicationController
  before_action :authenticate_mentor!

  def edit
    @mentor = Mentor.find(params[:id])
    @mentor_profile = @mentor.mentor_profile
  end

  def update
    @mentor = Mentor.find(params[:id])
    @mentor_profile = @mentor.mentor_profile

    if @mentor_profile.update!(mentor_profile_params)
      redirect_to edit_mentor_profile_path(mentor_id: @mentor.id), notice: "Your profile was updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def mentor_profile_params
    params.require(:mentor_profile).permit(
      :country,
      :city,
      :workplace_url,
      :writing_ruby,
      :start_source,
      :twitter,
      :github,
      :personal_site,
      :other_languages,
      :past_career,
      :mentoring_goal,
      mentor_attributes: [:id, :first_name, :last_name]
    )
  end
end
