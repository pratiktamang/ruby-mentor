class MentorsController < ApplicationController
  before_action :authenticate_mentor!
  before_action :set_mentor

  def show
  end

  private

  def set_mentor
    @mentor = Mentor.find(params[:id])
  end
end
