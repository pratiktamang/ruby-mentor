class PagesController < ApplicationController
  skip_before_action :authenticate, only: [:homepage]

  def homepage
    if current_mentee
      redirect_to mentees_dashboard_path
    elsif current_mentor
      redirect_to mentors_dashboard_path
    end
  end
end
