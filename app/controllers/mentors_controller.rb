class MentorsController < ApplicationController
  before_action :authenticate_mentor!

  def show
    @mentor = Mentor.find(params[:id])
  end
end
