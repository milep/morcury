Morcury::Application.routes.draw do
  mount Mercury::Engine => '/'

  devise_for :users

  get 'home/index'
  root :to => "home#index"

end
