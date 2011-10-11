class TriviaQuestion < ActiveRecord::Base
  belongs_to :quiz

  validates_presence_of :weight, :question
  validates_inclusion_of :enabled, :in => [true, false] 

  validates_each :correct_answers_raw, :incorrect_answers_raw do |record, attr, value|
    if(value.nil?)
      record.errors.add(attr, 'can\'t be nil')
    end
  end    

  VERSIONABLE_CHANGES = ['quiz_id', 'question', 'correct_answers_raw', 'incorrect_answers_raw'] unless defined? VERSIONABLE_CHANGES
  
  def select_multiple?
    (correct_answers.size > 1)
  end

  def correct_answers
    parse_answers(correct_answers_raw)
  end

  def incorrect_answers
    parse_answers(incorrect_answers_raw)
  end

  def parse_answers(str_answers)
    str_answers.split(';')
  end

  def choices
    # Cache choices to make sure this instance of this question keeps consistent choice ordering.
    @choices ||= (correct_answers + incorrect_answers).shuffle
  end

  def is_correct?(selection)
    if(!selection.is_a?(Array))
      selection = selection.empty? ? [] : [ selection ]
    end
    correct_answers.sort == selection.sort
  end

  def create_new_version?(changes)
    #logger.debug("Checking for new version. Current Question: #{self.attributes.inspect}. New Version: #{changes.inspect}")
    VERSIONABLE_CHANGES.any? do |attr|
      self[attr].to_s != changes[attr].to_s
    end
  end
end
