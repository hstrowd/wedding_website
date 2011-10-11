class ApplicationController < SarrisonController
  protect_from_forgery
  layout 'application', :except => :index

  before_filter :set_nav_id

  before_filter :login_filter

  def photo_album
    @page = 1

    if(params['page'])
      case params['page']
      when Integer
        @page = params['page']
      when String
        if(params['page'] =~ /[0-9]+/)
          @page = params['page'].to_i
        end
      end
    end
  end

  def video_album
    @page = 1

    if(params['page'])
      case params['page']
      when Integer
        @page = params['page']
      when String
        if(params['page'] =~ /[0-9]+/)
          @page = params['page'].to_i
        end
      end
    end
  end

end
