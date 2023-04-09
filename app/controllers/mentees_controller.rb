class MenteesController < ApplicationController
  before_action :authenticate_mentee!
  before_action :set_mentee, only: [:show, :edit, :update, :destroy]

  def index
    @mentees = Mentee.all
  end

  def show
  end

  def new
    @mentee = Mentee.new
  end

  def create
    @mentee = Mentee.new(mentee_params)
    if @mentee.save
      redirect_to mentees_mentee_path(@mentee), notice: "Mentee was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @mentee.update(mentee_params)
      redirect_to mentees_mentee_path(@mentee), notice: "Mentee was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @mentee.destroy
    redirect_to mentees_mentees_path, notice: "Mentee was successfully deleted."
  end

  private

  def set_mentee
    @mentee = Mentee.find(params[:id])
  end

  def mentee_params
    params.require(:mentee).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
