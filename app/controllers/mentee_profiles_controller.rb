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
      redirect_to edit_mentee_profile_path(mentor_id: @mentor.id), notice: "Your profile was updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def mentee_profile_params
    params.require(:mentee_profile).permit(
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
      mentor_attributes: [:id, :first_name, :last_name]
    )
  end
end
