module ApplicationHelper
  # Identifies if a user is currently logged in.
  def logged_in?
    !session[:user].nil?
  end

  def admin_user?
    session[:user] && session[:user].admin?
  end

  def format_picture(source, options = {})
    if options[:class] 
      options[:class] << ' picture'
    else
      options[:class] = 'picture'
    end
    link_to(image_tag(source, options), image_path(source), :class => 'picture')
  end

  def wedding_date
    "16-06-2012".to_date
  end

  def num_images_for_side_column
    3
  end

  def navigation_hash
    { 'Welcome' => 'welcome',
      'About Us' => 'about_us',
      'Our Story' => 'our_story',
      'The Proposal' => 'proposal',
      'Bridal Party' => 'bridal_party',
      'Travel' => 'travel',
      'Accommodations' => 'accommodations',
      'Local Activities' => 'activities',
      # Weekend Schedule
      'Rehearsal Dinner' => 'rehearsal_dinner',
      'Wedding Day Brunch' => 'wedding_day_brunch',
      'Ceremony & Reception' => 'ceremony',
      'Registries' => 'registries',
      'Photo Album' => 'photo_album',
      'Video Album' => 'video_album',
      'Quizzes' => 'quizzes',
      'Guestbook' => 'guestbook_entries' }
  end

  def admin_navigation_hash
    { 'Admin Panel' => ['/admin'],
      'Logout' => [logout_users_path]}
  end

  def groomsmen_info
    [ {:name => 'groomsman_1', :bio => "Bio.", :best => true},
      {:name => 'groomsman_2', :bio => "Bio."} ]
  end

  def bridesmaids_info
    [ {:name => 'bridesmaids_1', :bio => "Bio.", :best => true},
      {:name => 'bridesmaids_2', :bio => "Bio."} ]
  end

  def registries_info
    [ {:retailer => 'giftregistry360', :url => 'http://www.google.com/'} ]

  end

  # The set of ablums to be displayed.
  unless defined? PHOTO_ALBUMS
    PHOTO_ALBUMS =  [ {:name => 'chicago',       :title => 'Chicago',                 :thumb => 'liz in chi town.jpg'} ]
  end

  def num_photo_album_pages
    (PHOTO_ALBUMS.size / 4.0).ceil
  end

  def photo_album_gallery(page=1)
    albums_to_display = PHOTO_ALBUMS[((page - 1) * 4)...(page * 4)]

    # Searches the directory with the album name and appends an array of images to each album.
    append_images(albums_to_display)

    albums_to_display
  end

  def append_images(albums)
    albums.each do |album_info|
      dir_path = RAILS_ROOT + "/public/images/photo_album/#{album_info[:name]}"

      if(File.directory?(dir_path))
        album_dir = Dir.new(dir_path)

        # Build up the list of images for this album.
        album_info[:images] = []
        album_dir.each do |filename|
          unless(['.','..'].include?(filename))
            album_info[:images] << filename
          end
        end

        # Ensure a thumbnail image is selected.
        unless(File.exists?("#{dir_path}/#{album_info[:thumb]}") && File.file?("#{dir_path}/#{album_info[:thumb]}"))
          album_info[:thumb] = album_info[:images].shift
        else
          album_info[:images].delete(album_info[:thumb])
        end
      else
        # Any bad data should be removed from this hash.
        albums.delete(album_info)
      end
    end
  end
  private :append_images


  # The set of ablums to be displayed.
  unless defined? VIDEO_ALBUMS
    VIDEO_ALBUMS =  [ {:name => 'trying_to_escape',   :title => 'Trying to Escape',          :file_type => 'mov'} ]

  end

  def num_video_album_pages
    (VIDEO_ALBUMS.size / 4.0).ceil
  end

  def video_album_gallery(page=1)
    albums_to_display = VIDEO_ALBUMS[((page - 1) * 4)...(page * 4)]

    albums_to_display
  end
end
