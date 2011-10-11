class AddChainingToTriviaQuestions < ActiveRecord::Migration
  def self.up
    add_column :trivia_questions, :next_version, :integer
  end

  def self.down
    remove_column :trivia_questions, :next_version
  end
end
