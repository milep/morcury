Morcury::Application.routes.draw do

  namespace :admin do
    constraints :domain => 'localhost' do
      get '/' => 'home#index'

      resources :sites
    end
  end

  get "pages/properties"
  put "pages/update_properties"
  
  # get "pages/show"
  root :to => 'pages#show', :via => :get
  put '/' => "pages#mercury_update"

  mount Mercury::Engine => '/'

  devise_for :users, :controllers => { 
    :registrations => "users/registrations" }

  get '/(:locale)' => "pages#show", :locale => /\w{2}/
  put '/(:locale)' => "pages#mercury_update", :locale => /\w{2}/
  scope "(:locale)", :locale => /\w{2}/ do
    get '*slug' => 'pages#show', :as => :show_page
  end
  scope "(:locale)", :locale => /\w{2}/ do
    put '*slug' => 'pages#mercury_update', :as => :update_page
  end

end
