class CreateQuizAttempts < ActiveRecord::Migration
  def change
    create_table :quiz_attempts do |t|
      t.belongs_to :quiz
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
