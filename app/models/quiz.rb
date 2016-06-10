class Quiz < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: {maximum: 255}, allow_nil: true
end
