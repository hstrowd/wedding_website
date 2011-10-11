class QuizAttempt < ActiveRecord::Base
  belongs_to :quiz
  has_many :trivia_question_attempts

  validates_presence_of :score

  def calculate_score(selections)
    question_attempts = []
    number_correct = 0

    quiz.trivia_questions.each do |question|
      if(!(selection = selections["question#{question.id}"]) || selection.nil?)
        selection = question.select_multiple? ? [] : ''
      end
      if(selection.is_a?(Array))
        selection_raw = selection.join(';')
      else 
        selection_raw = selection
      end
      question_attempt = TriviaQuestionAttempt.new(:quiz_attempt => self, 
                                                   :trivia_question => question,
                                                   :selection => selection_raw)
      if(question.is_correct?(selection))
        question_attempt.correct = true
        number_correct += 1
      else
        question_attempt.correct = false
      end
      question_attempts << question_attempt
    end

    self.score = (number_correct.to_f / question_attempts.size())
    self.trivia_question_attempts = question_attempts

    score
  end

  ENCOURAGEMENT = { 
    'easy' => {
      'good' => 'Great job! You\'ve got the basics down pat. Next step: Medium Skill Level. Good Luck.',
      'ok' => 'Well done. Take a look around the site and see if you can find the answers to some of the questions you missed.',
      'bad' => 'That\'s alright. Most of the answers to the easy questions can be found on the site somewhere. Take a look around, and give it another shot.'
    }, 
    'med' => {
      'good' => 'Very nice!! Your sure know your stuff. Feel like pressing your luck with a hard quiz?',
      'ok' => 'Well done. With a little research around the site, you\'ll be ready for hard in no time.',
      'bad' => 'That\'s alight. Take a look around. Maybe you\'ll find some of the answers on the other pages.'
    },
    'hard' => {
      'good' => 'Wow!! Sara and I didn\'t even do that well on this quiz. Way to go!',
      'ok' => 'Great job! You\'re almost there. You know us really well.',
      'bad' => 'That\'s alright. There were some really tricky questions in there. Hope you had fun anyways.'
    }
  } unless defined? ENCOURAGEMENT

  def encouragement
    ENCOURAGEMENT[quiz.skill_level][grade]
  end

  def grade
    if(score > 0.75)
      'good'
    elsif(score > 0.4)
      'ok'
    else
      'bad'
    end
  end
end
