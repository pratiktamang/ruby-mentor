class Admin::MentorsController < ApplicationController
  def index
    @mentors = Mentee.all
  end
end
