class RolesController < SarrisonController
  protect_from_forgery
  layout 'application'

  before_filter :admin_filter

  # ---------------------
  #   Role Creation
  # ---------------------

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(params[:role])

    if @role.save
      redirect_to :controller => 'admin', :action => 'index'
    else
      respond_to do |format|
        format.html { render :action => "new" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end


  def edit
    @role = Role.find_by_id(params[:id])
  end

  def update
    @role = Role.find(params[:id])

    if @role.update_attributes(params[:role])
      redirect_to :controller => 'admin', :action => 'index'
    else
      respond_to do |format|
        format.html { render :action => "edit" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

end
