class Admins::MatchesController < ApplicationController
  before_action :authenticate_admin!
  include Pagy::Backend

  def index
    @pagy, @mentorships = pagy(Mentorship.all, items: 25)
  end
end
