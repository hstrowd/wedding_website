class Quiz < ActiveRecord::Base
  has_many :trivia_questions, 
           :conditions => ['enabled = ?', true],
           :order => 'weight ASC'
  has_many :quiz_attempts, :order => 'created_at DESC'

  validates_presence_of :title, :internal_name, :weight
  validates_numericality_of :weight

  def avg_score
    QuizAttempt.average('score', :conditions => ['quiz_id = ? AND exclude = ?', self.id, false])
  end

  def current_trivia_questions
    TriviaQuestion.find(:all, :conditions => ['quiz_id = ? AND (enabled = ? OR next_version IS NULL)', self.id, true], :order => 'weight ASC')
  end

  def skill_level
    case internal_name
    when /^easy/
      'easy'
    when /^med/
      'med'
    when /^hard/
      'hard'
    end
  end
end
