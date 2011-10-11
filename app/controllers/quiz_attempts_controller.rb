class QuizAttemptsController < SarrisonController
  protect_from_forgery
  layout 'application'

  def update_exclusions
    if(!params.blank?)
      params.each_pair do |key, value|
        if((key =~ /quiz_attempt(\d+)/) && (attempt = QuizAttempt.find_by_id($1)) &&
           (attempt.exclude != value['exclude']))
          attempt.exclude = value['exclude']
          attempt.save!
        end
      end
    end
    redirect_to :controller => 'admin', :action => 'index'
  end
end
