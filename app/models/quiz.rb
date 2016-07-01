class Quiz < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: {maximum: 255}, allow_nil: true
  belongs_to :user

  has_one :question, dependent: :destroy
  accepts_nested_attributes_for :question, allow_destroy: true, reject_if: :all_blank
end
