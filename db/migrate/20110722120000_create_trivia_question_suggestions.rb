class CreateTriviaQuestionSuggestions < ActiveRecord::Migration
  def self.up
    create_table :trivia_question_suggestions do |t|
      t.string :author, :null => false
      t.string :email
      t.string :suggested_question, :null => false
      t.string :suggested_answer, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :trivia_question_suggestions
  end
end
