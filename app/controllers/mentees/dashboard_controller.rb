class Mentees::DashboardController < ApplicationController
  before_action :authenticate_mentee!

  def index
  end
end
