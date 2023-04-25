class Admins::MenteesController < ApplicationController
  before_action :authenticate_admin!
  include Pagy::Backend
  include Filterable

  def index
    query = params[:query]
    filter_params = {query: query}.merge(params.permit(Mentee::FILTER_PARAMS))
    @pagy, @mentees = pagy(filter!(:mentee, filter_params), items: 25)
    @mentee_headers = MenteeProfile.column_names.reject { |c| c == "id" || c == "mentee_id" || c == "created_at" || c == "updated_at" }
  end
end
