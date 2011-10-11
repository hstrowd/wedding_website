class QuizzesController < SarrisonController
  protect_from_forgery
  layout 'application'

  def self.nav_id ; 'quizzes' end
  before_filter :set_nav_id

  before_filter :login_filter
  before_filter :admin_filter, :except => [:index, :show, :score]

  def index
    @quizzes = Quiz.find(:all, :order => 'weight ASC')
  end

  def show
    unless(params[:id])
      flash['error'] = "The ID of a quiz must be provided."
      render(:action => 'index')
    end

    @quiz = Quiz.find_by_id(params[:id])

    unless(@quiz)
      flash['error'] = "Unable to find quiz with id: #{params[:id]}"
      render(:action => 'index')
    end
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(params[:quiz])

    if @quiz.save
      redirect_to :controller => 'admin', :action => 'index'
    else
      respond_to do |format|
        format.html { render :action => "new" }
        format.xml  { render :xml => @quiz.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @quiz = Quiz.find_by_id(params[:id])
  end

  def update
    @quiz = Quiz.find(params[:id])

    if @quiz.update_attributes(params[:quiz])
      redirect_to :controller => 'admin', :action => 'index'
    else
      respond_to do |format|
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quiz.errors, :status => :unprocessable_entity }
      end
    end
  end

  def score
    logger.info("QuizController#score: Quiz #{params[:quiz_id]} response: #{params.inspect}")

    @quizzes = Quiz.find(:all, :order => 'weight ASC')
    if(quiz = Quiz.find_by_id(params[:quiz_id]))
      begin
        @quiz_attempt = QuizAttempt.new(:quiz => quiz, :exclude => false)
        @quiz_attempt.calculate_score(params)
        @quiz_attempt.save!
      rescue Exception => error
        logger.error("QuizController#score: Error during quiz scoring: #{error.message}\n #{error.backtrace * "\n"}")
        flash['error'] = [ "An error occured in scoring your quiz. Please try again." ]
        render(:action => 'index')
        return
      end
      render(:action => 'quiz_results')
    else
      logger.error("QuizController#score: Quiz id not specified.")
      flash['error'] = [ "An error occured in scoring your quiz. Please try again." ]
      render(:action => 'index')
    end
  end
end
