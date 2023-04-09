class MentorsController < ApplicationController
  before_action :authenticate_mentor!
  before_action :set_mentor, only: [:show, :edit, :update, :destroy]

  def index
    @mentors = Mentor.all
  end

  def show
  end

  def new
    @mentor = Mentor.new
  end

  def create
    @mentor = Mentor.new(mentor_params)
    if @mentor.save
      redirect_to mentors_mentor_path(@mentor), notice: "Mentor was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @mentor.update(mentor_params)
      redirect_to mentors_mentor_path(@mentor), notice: "Mentor was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @mentor.destroy
    redirect_to mentors_mentors_path, notice: "Mentor was successfully deleted."
  end

  private

  def set_mentor
    @mentor = Mentor.find(params[:id])
  end

  def mentor_params
    params.require(:mentor).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
