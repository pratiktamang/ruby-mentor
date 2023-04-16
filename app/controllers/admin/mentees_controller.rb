class Admin::MenteesController < ApplicationController
  def index
    @mentees = Mentee.all
  end
end
