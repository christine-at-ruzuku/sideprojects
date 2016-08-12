class CreateQuizAttempts < ActiveRecord::Migration
  def change
    create_table :quiz_attempts do |t|
      t.integer :quiz_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
