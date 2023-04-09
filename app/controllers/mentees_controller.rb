class MenteesController < ApplicationController
  before_action :authenticate_mentee!

  def show
    @mentee = Mentee.find(params[:id])
  end
end
