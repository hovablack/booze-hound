Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'

  get 'auth/:provider/callback', to: 'sessions#omniauth'
  # match 'auth/:provider/callback', to: 'auth#callback', via: [:get, :post]
  
  get 'register', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :reviews
  resources :users do
    resources :drinks, only: :index
  end
  resources :drinks do
    resources :reviews, only: [:new, :create, :index]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
