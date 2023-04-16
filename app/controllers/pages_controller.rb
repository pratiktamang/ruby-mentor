class PagesController < ApplicationController
  include Accessible
  skip_before_action :check_resource, only: :homepage

  def homepage
  end
end
