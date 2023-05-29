Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'
  resources :articles
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  delete '/logout', to: 'sessions#destroy', as: :logout
  get '/search', to: 'search#search'
  get '/home', to: 'home#index'
  root "home#index"

  resources :jobs do
    resources :applies, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
    get:liked, on: :collection
  end

  resources :jobs do
    resources :reviews
  end

  get '/applications', to: 'jobs#applications', as: 'applications'


  resource :sessions

  resources :users do
    member do
      get :change_password
      patch :update_password
    end
  end

  resources :applies, only: [:index]

  resources :applies do
    patch 'update_status', on: :member
    get 'send_monthly_analysis', on: :collection
  end

  resources :password_resets, only: [:new, :create, :edit, :update]

# get '/forgot_password', to: 'users#forgot_password', as: 'forgot_password'
# post '/forgot_password', to: 'users#send_reset_password_email', as: 'send_reset_password_email'
# get '/reset_password', to: 'users#reset_password', as: 'reset_password'
# patch '/reset_password', to: 'users#update_password', as: 'update_password'
end
