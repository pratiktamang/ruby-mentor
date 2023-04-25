class Admins::MentorsController < ApplicationController
  before_action :authenticate_admin!
  include Pagy::Backend
  include Filterable

  def index
    query = params[:query]
    filter_params = {query: query}.merge(params.permit(Mentor::FILTER_PARAMS))
    @pagy, @mentors = pagy(filter!(:mentor, filter_params), items: 25)
    @mentor_headers = MentorProfile.column_names.reject { |c| c == "id" || c == "mentor_id" || c == "created_at" || c == "updated_at" }
  end
end
