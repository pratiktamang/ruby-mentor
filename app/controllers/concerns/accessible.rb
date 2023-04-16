module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_resource
  end

  protected

  def check_resource
    flash.clear
    if mentor_signed_in?
      redirect_to mentors_dashboard_path
    elsif mentee_signed_in?
      redirect_to mentees_dashboard_path
    elsif admin_signed_in?
      redirect_to admin_dashboard_path
    else
      redirect_to root_path
    end
  end
end
