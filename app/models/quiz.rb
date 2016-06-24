class Quiz < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: {maximum: 255}, allow_nil: true
  belongs_to :user

  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: :all_blank
end
