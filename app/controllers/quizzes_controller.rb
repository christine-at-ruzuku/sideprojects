class QuizzesController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  # before_action :admin_user,     only: :destroy

  def index
    @quizzes = Quiz.paginate(page: params[:page], :per_page => 10)
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)
    if @quiz.save
      flash[:success] = "Way to make a new quiz!"
      redirect_to @quiz
    else
      render 'new'
    end
  end

  def show
    @quiz = Quiz.find(params[:id])
  end

  def edit
    @quiz = Quiz.find(params[:id])
  end

  def update
    @quiz = Quiz.find(params[:id])
    if @quiz.update_attributes(quiz_params)
      flash[:success] = "Quiz Updated"
      redirect_to @quiz
    else
      render 'edit'
    end
  end

  def destroy
    Quiz.find(params[:id]).destroy
    flash[:success] = "Quiz deleted"
    redirect_to quizzes_path
  end

  private

    def quiz_params
      params.require(:quiz).permit(:title, :description)
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @quiz = Quiz.find(params[:id])
      redirect_to(root_url) unless current_user?(@quiz)
    end

    # Confirms an admin user.
    # def admin_user
    #   redirect_to(root_url) unless current_user.admin?
    # end
end
