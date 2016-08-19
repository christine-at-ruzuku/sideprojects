class CreateQuizResponses < ActiveRecord::Migration
  def change
    create_table :quiz_responses do |t|
      t.belongs_to :quiz_attempt
      t.belongs_to :question
      t.belongs_to :answer

      t.timestamps null: false
    end
  end
end
