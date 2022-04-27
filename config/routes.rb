Rails.application.routes.draw do
  devise_for :users
  resources :payments
  resources :categories
  get '/user', to: 'categories#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#index"
end
