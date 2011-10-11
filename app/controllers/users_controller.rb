class UsersController < SarrisonController
  protect_from_forgery
  layout 'application'

  before_filter :login_filter, :except => [:login, :authenticate, :logout]
  before_filter :admin_filter, :only => [:new, :create]

  # ---------------------
  #   User Creation
  # ---------------------

  def new
    @user = User.new
    @user.enabled = true
  end

  def create
    attributes = params[:user] || {}

    if(params[:roles] && !params[:roles].empty?)
      attributes.merge!({:roles => params[:roles].collect{ |id| Role.find_by_id(id) }}) 
    else
      attributes[:roles] = []
    end

    @user = User.new(attributes)

    if @user.save
      redirect_to :controller => 'admin', :action => 'index'
    else
      respond_to do |format|
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find(params[:id])
    attributes = params[:user] || {}
    attributes.delete(:password) if attributes[:password].blank?

    if(params[:roles] && !params[:roles].empty?)
      attributes.merge!({:roles => params[:roles].collect{ |id| Role.find_by_id(id) }}) 
    else
      attributes[:roles] = []
    end

    if @user.update_attributes(attributes)
      redirect_to :controller => 'admin', :action => 'index'
    else
      respond_to do |format|
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end


  # -----------------------
  #   User Authentication
  # -----------------------

  def login
    if !logged_in?
      render :layout => 'intro'
    else
      redirect_to :controller => 'application', :action => 'welcome'
    end
  end

  def authenticate
    if(params[:login] && params[:login][:password])
      # Authenticate the provided information
      if(user = User.authenticate(params[:login][:password]))
        # Create a session with users id
        session[:user] = user
        redirect_to :controller => 'application', :action => 'welcome'
      else
        session[:user] = nil
        flash[:notice] = "Invalid Password"
        redirect_to :action => 'login'
      end
    else
      session[:user] = nil
      flash[:notice] = "Password required to access the site."
      redirect_to :action => 'login'
    end
  end

  def logout
    session[:user] = nil
    redirect_to :action => 'login'
  end
end
