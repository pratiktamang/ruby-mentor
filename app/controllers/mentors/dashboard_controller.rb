class Mentors::DashboardController < ApplicationController
  before_action :authenticate_mentor!
  def index
  end
end
