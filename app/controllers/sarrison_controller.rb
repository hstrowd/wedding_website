class SarrisonController < ActionController::Base
  include ApplicationHelper

  def login_filter
    unless logged_in?
      flash[:notice] = "You must first log in."
      # TODO: Pass a parameter to this action indicating where the user should be taken after they login.
      redirect_to :controller => 'users', :action => 'login'
    end
  end

  def admin_filter
    unless admin_user?
      flash[:notice] = "You do not have permission to access this content."
      redirect_to welcome_path
    end
    @nav_id = 'admin'
  end

  def self.nav_id ; nil end

  def set_nav_id
    @nav_id = self.class.nav_id || params[:action]
  end
end
