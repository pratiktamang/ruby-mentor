class Admins::MatchesController < ApplicationController
  before_action :authenticate_admin!
  include Pagy::Backend
  include Filterable

  def index
    query = params[:query]
    filter_params = {query: query}.merge(params.permit(Mentorship::FILTER_PARAMS))
    @pagy, @mentorships = pagy(filter!(:mentorship, filter_params), items: 25)
  end
end
