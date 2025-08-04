Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  resources :tags do
  get 'tweets', to: 'tweets#search'  
  get 'tweets/:id' => 'tweets#show',as: 'tweet'
  patch 'tweets/:id' => 'tweets#update'
  delete 'tweets/:id' => 'tweets#destroy'
  get 'tweets/:id/edit' => 'tweets#edit', as:'edit_tweet'
end
  resources :tweets do
  resources :likes, only: [:create, :destroy]
end
  root 'tweets#index'
end