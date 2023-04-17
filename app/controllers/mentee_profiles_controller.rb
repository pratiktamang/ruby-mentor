class MenteeProfilesController < ApplicationController
  before_action :authenticate_mentee!

  def edit
    @mentee = Mentee.find(params[:id])
    @mentee_profile = @mentee.mentee_profile
  end

  def update
    @mentee = Mentee.find(params[:id])
    @mentee_profile = @mentee.mentee_profile

    if @mentee_profile.update!(mentee_profile_params)
      redirect_to edit_mentee_profile_path(@mentee), notice: "Your profile was updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def mentee_profile_params
    params.require(:mentee_profile).permit(
      :country,
      :city,
      :workspace_url,
      :writing_ruby,
      :start_source,
      :underrepresented_group,
      :twitter,
      :github,
      :personal_site,
      :other_languages,
      :past_career,
      :mentoring_goals,
      mentee_attributes: [:id, :first_name, :last_name]
    )
  end
end
