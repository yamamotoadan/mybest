Rails.application.routes.draw do
  devise_for :users
  
  get 'users/show/iine/:id', to: 'users#iine', as: 'user_iine'
  get 'users/mypage/:id', to: 'users#mypage', as: 'user_mypage'

  resources :users, only: [:show]

  resources :tweets do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    
    member do
      get 'next', to: 'tweets#next'
      get 'prev', to: 'tweets#prev'
    end
  end

  root 'tweets#index'
end