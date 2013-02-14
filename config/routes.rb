Morcury::Application.routes.draw do

  namespace :admin do
    constraints :host => Figaro.env.admin_domain do
      get '/' => 'home#index'

      resources :sites do
        resources :images
      end
    end
  end

  resources :pages do
    get 'properties', :on => :collection
    put 'update_properties', :on => :collection
    put 'move_up', :on => :member
    put 'move_down', :on => :member
  end

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
