class AdminController < SarrisonController
  protect_from_forgery
  layout 'application'

  before_filter :admin_filter

  def index
    @users = User.all(:order => 'created_at ASC')
    @roles = Role.all(:order => 'created_at ASC')

    @guestbook_entries = GuestbookEntry.all(:order => 'created_at ASC')
    @quizzes = Quiz.all(:order => 'weight ASC')
    @suggested_questions = TriviaQuestionSuggestion.all(:order => 'created_at ASC')
  end
end
