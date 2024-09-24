Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'users/show/iine/:id', to: 'users#iine'
  resources :users, only: [:show, :iine, :mypage]
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