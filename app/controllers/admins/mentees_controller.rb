class Admins::MenteesController < ApplicationController
  before_action :authenticate_admin!
  include Pagy::Backend

  def index
    @pagy, @mentees = pagy(Mentee.all.includes(:mentee_profile), items: 25)
    @mentee_headers = MenteeProfile.column_names.reject { |c| c == "id" || c == "mentee_id" || c == "created_at" || c == "updated_at" }
  end
end
