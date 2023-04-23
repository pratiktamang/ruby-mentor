class Admins::MenteesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @mentees = Mentee.all
    @mentee_headers = MenteeProfile.column_names.reject { |c| c == "id" || c == "mentee_id" || c == "created_at" || c == "updated_at" }
  end
end
