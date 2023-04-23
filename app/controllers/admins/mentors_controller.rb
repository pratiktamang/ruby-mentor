class Admins::MentorsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @mentors = Mentor.all
    @mentor_headers = MentorProfile.column_names.reject { |c| c == "id" || c == "mentor_id" || c == "created_at" || c == "updated_at" }
  end
end
