class QuizzesController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :quiz_owner_user, only: [:edit, :update, :destroy]
  helper_method :quiz, :quizzes

  def index
    @quizzes = Quiz.paginate(page: params[:page], :per_page => 10)
  end

  def new
    @quiz = Quiz.new
    prepopulate_question
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
    @quiz.questions = Question.where(quiz_id: params[:id])
    @quiz.questions.reject(&:id).each do |question|
      question.answers = Answer.where(question_id: question.id)
    end
  end

  def edit
    if !quiz_owner?(params[:id])
      redirect_to quizzes_path
      flash[:error] = "Step Off!! You don't own that quiz."
    end

    @quiz = Quiz.find(params[:id])
    @quiz.questions = Question.where(quiz_id: params[:id])
    question = @quiz.questions.build if @quiz.questions.nil?

    if @quiz.questions.nil?
      question = @quiz.questions.build
      question.answers.build if question.answers.nil? || question.answers.size < 1
    else
      @quiz.questions.each do |question|
        question.answers = Answer.where(question_id: question.id)
        question.answers.build if question.answers.nil? || question.answers.size < 1
      end
    end
  end

  def update
    @quiz = Quiz.find(params[:id])

    if @quiz.update_attributes(quiz_params)
      flash[:success] = "Awesome! You updated your quiz."
      redirect_to @quiz
    else
      render 'edit'
    end
  end

  def destroy
    Quiz.find(params[:id]).destroy
    flash[:success] = "Your quiz has been obliterated!"
    redirect_to quizzes_path
  end

  private

    def quiz
      @quiz
    end

    def quizzes
      @quizzes
    end

    def quiz_params
      params.require(:quiz).permit(:title, :description, questions_attributes: [ :id, :title, :_destroy, answers_attributes: [:id, :answer, :selected, :_destroy]])
    end

    def prepopulate_question
      question = @quiz.questions.build
      question.answers.build
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
