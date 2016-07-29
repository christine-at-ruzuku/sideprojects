class Question < ActiveRecord::Base
  belongs_to :quiz

  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: :all_blank

  has_many :attempts, dependent: :destroy
  accepts_nested_attributes_for :attempts, allow_destroy: true, reject_if: :all_blank
end
