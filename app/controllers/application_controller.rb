class ApplicationController < ActionController::Base
  before_action :authenticate

  private

  def authenticate
    redirect_to root_path unless mentor_signed_in? || mentee_signed_in?
  end
end
