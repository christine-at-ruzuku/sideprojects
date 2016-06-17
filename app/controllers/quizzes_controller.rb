class QuizzesController < ApplicationController
  before_action :quiz_owner?, only: [:edit, :update, :destroy]

  def index
    @quizzes = Quiz.paginate(page: params[:page], :per_page => 10)
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.user_id = current_user.id

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

    def quiz_owner?
      @quiz = Quiz.find(params[:id])
      quiz_user = User.find_by_id(@quiz.user_id)
      session_user = User.find_by_id(session['user_id'])
      session_user.id == quiz_user.id if quiz_user.present? && session_user.present?
    end
end
