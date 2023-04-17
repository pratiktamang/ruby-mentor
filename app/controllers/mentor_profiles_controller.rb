class MentorProfilesController < ApplicationController
  before_action :authenticate_mentor!
  before_action :set_mentor_profile

  def edit
  end

  def update
    if @mentor_profile.update!(mentor_profile_params)
      redirect_to edit_mentor_profile_path(mentor_id: @mentor.id), notice: "Your profile was updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_mentor_profile
    @mentor = Mentor.find(params[:id])
    @mentor_profile = @mentor.mentor_profile
  end

  def set_mentor
  end

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
      mentor_attributes: [:id, :first_name, :last_name, :email]
    )
  end
end
