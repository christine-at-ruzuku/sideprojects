class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :answer
      t.integer :quiz_id
      t.boolean :selected

      t.timestamps null: false
    end
  end
end
