class CreateQuizResponses < ActiveRecord::Migration
  def change
    create_table :quiz_responses do |t|
      t.integer :quiz_attempt_id
      t.integer :question_id
      t.integer :answer_id

      t.timestamps null: false
    end
  end
end
