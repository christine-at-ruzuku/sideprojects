class QuizzesController < ApplicationController
  def index
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
  end

  def edit
  end

  def update
  end
  private 

  def quiz_params
    params.require(:quiz).permit(:title, :description)
  end

end
