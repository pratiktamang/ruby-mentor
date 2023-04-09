module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_resource
  end

  protected

  def check_resource
    if mentor_signed_in?
      flash.clear
      redirect_to(mentors_authenticated_root_path) and return
    elsif mentee_signed_in?
      flash.clear
      redirect_to(mentees_authenticated_root_path) and return
    end
  end
end
