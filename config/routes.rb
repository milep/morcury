Morcury::Application.routes.draw do

  namespace :admin do
    constraints :host => Figaro.env.admin_domain do
      get '/' => 'home#index'

      resources :sites do
        resources :images
      end
    end
  end

  get "pages/index"
  get "pages/properties"
  put "pages/update_properties"
  put "pages/move_up/:id" => "pages#move_up", :as => :pages_move_up
  put "pages/move_down/:id" => "pages#move_down", :as => :pages_move_down
  post "pages" => "pages#create", :as => :pages
  
  # get "pages/show"
  root :to => 'pages#show', :via => :get
  put '/' => "pages#mercury_update"

  mount Mercury::Engine => '/'

  devise_for :users, :controllers => { 
    :registrations => "users/registrations",
    :sessions => "users/sessions"
  }

  get '/(:locale)' => "pages#show", :locale => /\w{2}/
  put '/(:locale)' => "pages#mercury_update", :locale => /\w{2}/
  scope "(:locale)", :locale => /\w{2}/ do
    get '*slug' => 'pages#show', :as => :show_page
  end
  scope "(:locale)", :locale => /\w{2}/ do
    put '*slug' => 'pages#mercury_update', :as => :update_page
  end

end
