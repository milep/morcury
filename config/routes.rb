Morcury::Application.routes.draw do
  # get "pages/show"
  root :to => "pages#show", :via => :get
  root :to => "pages#mercury_update", :via => :put

  mount Mercury::Engine => '/'

  devise_for :users, :controllers => { 
    :registrations => "users/registrations" }

  match '/:locale' => "pages#show", :via => :get
  match '/:locale' => "pages#mercury_update", :via => :put
  scope "(:locale)", :locale => /fi|en|\w{2}/ do
    match '*slug' => 'pages#show', :via => :get, :as => :show_page
  end
  scope "(:locale)", :locale => /\w{2}/ do
    match '*slug' => 'pages#mercury_update', :via => :put, :as => :update_page
  end
end
