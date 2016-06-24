class QuizzesController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :quiz_owner_user, only: [:edit, :update, :destroy]

  def index
    @quizzes = Quiz.paginate(page: params[:page], :per_page => 10)
  end

  def new
    @quiz = Quiz.new
    @quiz.questions.build
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
    if !quiz_owner?(params[:id])
      redirect_to quizzes_path
      flash[:error] = "Step Off!! You don't own that quiz"
    end
    @quiz = Quiz.find(params[:id])
  end

  def update
    @quiz = Quiz.find(params[:id])
    @quiz.questions.build
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
      params.require(:quiz).permit(:title, :description, questions_attributes: [:title])
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms a quiz owner user.
    def quiz_owner_user
      unless quiz_owner?(params[:id])
        redirect_to quizzes_path
        flash[:error] = "Step Off!! You don't own that quiz"
      end
    end
end
