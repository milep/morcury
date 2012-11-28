Morcury::Application.routes.draw do
  # get "pages/show"
  root :to => "pages#show", :via => :get
  root :to => "pages#mercury_update", :via => :put

  mount Mercury::Engine => '/'

  devise_for :users, :controllers => { 
    :registrations => "users/registrations" }

  scope "(:locale)", :locale => /fi|en|\w{2}/ do
    match '*slug' => 'pages#show', :via => :get
  end
  scope "(:locale)", :locale => /\w{2}/ do
    match '*slug' => 'pages#mercury_update', :via => :put
  end
end
