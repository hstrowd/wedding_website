class TriviaQuestionAttempt < ActiveRecord::Base
  belongs_to :trivia_question
  belongs_to :quiz_attempt

  validates_presence_of :quiz_attempt, :trivia_question
  validates_inclusion_of :correct, :in => [true, false]

  validates_each :trivia_question, :selection do |record, attr, value|
    case attr
    when :trivia_question
      if(record.quiz_attempt && (!record.quiz_attempt.quiz || record.quiz_attempt.quiz != value.quiz))
        record.errors.add(attr, 'must be in the set of questions defined by the quiz attempt\'s quiz')
      end
    when :selection
      if(value.nil?)
        record.errors.add(attr, 'can\'t be nil')
      end
    end
  end

  def selection_to_s
    selection.split(';').join(', ')
  end
end
