class Admins::MentorsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @mentors = Mentor.all
  end
end
