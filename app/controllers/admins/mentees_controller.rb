class Admins::MenteesController < ApplicationController
  def index
    @mentees = Mentee.all
  end
end
