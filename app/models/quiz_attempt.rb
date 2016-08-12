class QuizAttempt < ActiveRecord::Base
  has_one :user
  has_many :quiz_responses
  accepts_nested_attributes_for :quiz_responses, allow_destroy: true, reject_if: :all_blank

end
