module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_resource
  end

  protected

  def check_resource
    if mentor_signed_in?
      flash.clear
      if current_mentor.onboarded
        redirect_to(mentors_dashboard_path) and return
      else
        redirect_to(new_mentor_onboarding_path(current_mentor)) and return
      end
    elsif mentee_signed_in?
      flash.clear
      if current_mentee.onboarded
        redirect_to(mentees_dashboard_path) and return
      else
        redirect_to(new_mentee_onboarding_path(current_mentee)) and return
      end
    end
  end
end
