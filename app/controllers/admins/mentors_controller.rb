class Admins::MentorsController < ApplicationController
  before_action :authenticate_admin!
  include Pagy::Backend

  def index
    @pagy, @mentors = pagy(Mentor.all.includes(:mentor_profile), items: 25)
    @mentor_headers = MentorProfile.column_names.reject { |c| c == "id" || c == "mentor_id" || c == "created_at" || c == "updated_at" }
  end
end
