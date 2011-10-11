class CreateQuizes < ActiveRecord::Migration
  def self.up
    create_table :quizzes do |t|
      t.string :title, :null => false
      t.string :internal_name, :null => false
      t.integer :weight, :null => false
      t.boolean :enabled, :null => false

      t.timestamps
    end

    create_table :trivia_questions do |t|
      t.integer :quiz_id, :null => false
      t.integer :weight, :null => false
      t.boolean :enabled, :null =>false
      t.string :question, :null => false
      t.text :correct_answers_raw, :null => false
      t.text :incorrect_answers_raw, :null => false

      t.timestamps
    end

    create_table :quiz_attempts do |t|
      t.integer :quiz_id, :null => false
      t.float :score, :null => false
      
      t.timestamps
    end

    create_table :trivia_question_attempts do |t|
      t.integer :trivia_question_id, :null => false
      t.integer :quiz_attempt_id, :null => false
      t.string :selection, :null => false
      t.boolean :correct, :null => false

      t.timestamps
    end



    easy1 = Quiz.create!(:title => 'Easy #1', :internal_name => 'easy1', :weight => 10, :enabled => true)



    TriviaQuestion.create!(:quiz                  => easy1,
                           :weight                => 10,
                           :enabled               => true,
                           :question              => 'Question 1?',
                           :correct_answers_raw   => 'Answer',
                           :incorrect_answers_raw => 'Wrong;Wronger;Wrongest')
    TriviaQuestion.create!(:quiz                  => easy1,
                           :weight                => 20,
                           :enabled               => true,
                           :question              => 'Question 2?',
                           :correct_answers_raw   => 'Right;Righter;Rightest',
                           :incorrect_answers_raw => 'Wrong')
  end

  def self.down
    drop_table :quizzes
    drop_table :trivia_questions
    drop_table :quiz_attempts
    drop_table :trivia_question_attempts
  end
end
