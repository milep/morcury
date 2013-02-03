Morcury::Application.routes.draw do
  # get "pages/show"
  get '/' => "pages#show"
  put '/' => "pages#mercury_update"

  mount Mercury::Engine => '/'

  devise_for :users, :controllers => { 
    :registrations => "users/registrations" }

  get '/:locale' => "pages#show"
  put '/:locale' => "pages#mercury_update"
  scope "(:locale)", :locale => /fi|en|\w{2}/ do
    get '*slug' => 'pages#show', :as => :show_page
  end
  scope "(:locale)", :locale => /\w{2}/ do
    get '*slug' => 'pages#mercury_update', :as => :update_page
  end
end
