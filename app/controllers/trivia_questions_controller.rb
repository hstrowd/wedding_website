class TriviaQuestionsController < SarrisonController
  protect_from_forgery
  layout 'application'

  before_filter :admin_filter

  def new
    @trivia_question = TriviaQuestion.new(:enabled => true)
  end

  def create
    @trivia_question = TriviaQuestion.new(params[:trivia_question])

    if @trivia_question.save
      redirect_to :controller => 'admin', :action => 'index'
    else
      respond_to do |format|
        format.html { render :action => "new" }
        format.xml  { render :xml => @trivia_question.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @trivia_question = TriviaQuestion.find_by_id(params[:id])
  end

  def update
    @trivia_question = TriviaQuestion.find(params[:id])

    if(@trivia_question.create_new_version?(params[:trivia_question]))
      if((new_trivia_question = TriviaQuestion.create(params[:trivia_question])) && !new_trivia_question.new_record?)
        @trivia_question.next_version = new_trivia_question.id
        @trivia_question.enabled = false

        if(@trivia_question.save)
          success = true
        end
      else
        logger.info("Unable to create a new trivia question for the new version of this question: #{params[:trivia_question].inspect}")
        
        # Update the original question's attributes so that the form keeps its values.
        @trivia_question.update_attributes(params[:trivia_question])
        @trivia_question.valid?
      end
    elsif(@trivia_question.update_attributes(params[:trivia_question]))
      success = true
    end
    
    if(success)
      redirect_to :controller => 'admin', :action => 'index'
    else
      respond_to do |format|
        format.html { render :action => "edit" }
        format.xml  { render :xml => @trivia_question.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_statuses
    if(!params.blank?)
      params.each_pair do |key, value|
        if((key =~ /question(\d+)/) && (question = TriviaQuestion.find_by_id($1)) &&
           (question.enabled != value['enabled']))
          question.enabled = value['enabled']
          question.save!
        end
      end
    end
    redirect_to :controller => 'admin', :action => 'index'
  end
end
