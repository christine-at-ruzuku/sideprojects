class QuizAttemptsController < ApplicationController
  helper_method :quiz, :quiz_attempt, :quiz_response

  def index
  end

  def new
      if (!params[:id])
        flash[:error] = 'There is no quiz by that ID'
        return redirect_to quizzes_path
      end

      @quiz_attempt = QuizAttempt.new
      @quiz_attempt.quiz_responses.build
  end

  def create
    @quiz_attempt = QuizAttempt.new(quiz_attempt_params)
    if @quiz_attempt.save
      flash[:success] = "Well hopefully you passed"
      redirect_to @quiz_attempt
    else
      render 'new'
    end
  end

  def show
  end

  private

    def quiz_attempt_params
      params.require(:quiz_attempt).permit(
        :quiz_id,
        quiz_responses_attributes: [ :question_id, :answer_id, :_destroy ]
      )
    end

    def quiz
      @quiz ||= Quiz.find(params[:id])
    end

    def quiz_attempt
      @quiz_attempt ||= QuizAttempt.new
    end

    def quiz_response
      @quiz_response ||= QuizReponse.new
    end
end
