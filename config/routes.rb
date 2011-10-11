SarrisonWedding::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  match 'welcome' => 'application#welcome'
  match 'about_us' => 'application#about_us'
  match 'our_story' => 'application#our_story'
  match 'proposal' => 'application#proposal'
  match 'bridal_party' => 'application#bridal_party'
  match 'travel' => 'application#travel'
  match 'accommodations' => 'application#accommodations'
  match 'activities' => 'application#activities'
  match 'rehearsal_dinner' => 'application#rehearsal_dinner'
  match 'wedding_day_brunch' => 'application#wedding_day_brunch'
  match 'ceremony' => 'application#ceremony'
  match 'reception' => 'application#reception'
  match 'registries' => 'application#registries'
  match 'photo_album' => 'application#photo_album'
  match 'video_album' => 'application#video_album'

  resources :users do
    collection do
      get 'login'
      post 'authenticate'
      get 'logout'
      post 'update_statuses'
    end
  end

  resources :roles do
  end

  match 'admin' => 'admin#index'

  resources :guestbook_entries do
    collection do
      post 'update_published_statuses'
    end
  end

  resources :quizzes do
    collection do
      post 'score'
    end
  end

  resources :trivia_questions do
    collection do
      post 'update_statuses'
    end
  end

  resources :quiz_attempts do
    collection do
      post 'update_exclusions'
    end
  end

  resources :trivia_question_suggestions do
  end
  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"
  root :to => "users#login"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
