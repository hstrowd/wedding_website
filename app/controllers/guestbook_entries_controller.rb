class GuestbookEntriesController < SarrisonController
  protect_from_forgery
  layout 'application'

  def self.nav_id ; 'guestbook_entries' end 
  before_filter :set_nav_id

  before_filter :login_filter
  before_filter :admin_filter, :except => [:index, :create]
  
  def index
    @entries = GuestbookEntry.all(:conditions => {:published => true}, 
                                  :order => 'created_at DESC')
    @entry = GuestbookEntry.new
    @entry.published = true
  end

  def create
    @entry = GuestbookEntry.new(params[:guestbook_entry])
    
    if @entry.save
      redirect_to(guestbook_entries_path, :notice => 'Entry was successfully created.')
    else
      @entries = GuestbookEntry.all
      flash['error'] = @entry.errors.full_messages
      render(:action => 'index')
    end
  end

  def edit
    @entry = GuestbookEntry.find_by_id(params[:id])
  end

  def update
    @entry = GuestbookEntry.find(params[:id])

    if @entry.update_attributes(params[:guestbook_entry])
      redirect_to :controller => 'admin', :action => 'index'
    else
      respond_to do |format|
        format.html { render :action => "edit" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_published_statuses
    if(!params.blank?)
      params.each_pair do |key, value|
        if((key =~ /entry(\d+)/) && (entry = GuestbookEntry.find_by_id($1)) &&
           (entry.published != value['published']))
          entry.published = value['published']
          entry.save!
        end
      end
    end
    redirect_to :controller => 'admin', :action => 'index'
  end
end
