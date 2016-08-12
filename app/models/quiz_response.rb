class QuizResponse < ActiveRecord::Base
  has_one :quiz
  has_one :answer
end
