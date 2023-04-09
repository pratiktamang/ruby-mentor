class PagesController < ApplicationController
  def homepage
    if current_mentee
      redirect_to mentees_authenticated_root_path
    elsif current_mentor
      redirect_to mentors_authenticated_root_path
    end
  end
end
