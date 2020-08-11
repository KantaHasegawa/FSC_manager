Rails.application.routes.draw do
  devise_for :users
  get 'static_pages/home'
  get 'static_pages/index'
  get 'static_pages/show'
  get 'static_pages/help'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  root to: 'static_pages#home'
  get '/users/sign_out' => 'devise/sessions#destroy'
end