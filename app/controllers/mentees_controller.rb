class MenteesController < ApplicationController
  def show
  end

  private

  def set_mentee
    @mentee = Mentee.find(params[:id])
  end
end
