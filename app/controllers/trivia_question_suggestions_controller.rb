class TriviaQuestionSuggestionsController < SarrisonController
  protect_from_forgery
  layout 'application'

  def self.nav_id ; 'quizzes' end
  before_filter :set_nav_id

  before_filter :login_filter

  def new
    @suggested_question = TriviaQuestionSuggestion.new
  end

  def create
    @suggested_question = TriviaQuestionSuggestion.new(params[:trivia_question_suggestion])

    if @suggested_question.save
      redirect_to(quizzes_path, :notice => 'Suggested question was successfully created.')
    else
      flash['error'] = @suggested_question.errors.full_messages
      render(:action => 'new')
    end
  end
end
