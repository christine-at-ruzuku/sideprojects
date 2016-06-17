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
    if !quiz_owner?
      redirect_to quizzes_path 
      flash[:error] = "Step Off!! You don't own that quiz"
    end
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
      current_user.id == params[:id].to_i
    end
end
