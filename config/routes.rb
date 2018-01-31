Rails.application.routes.draw do
  root 'static_pages#home'
  resources :workers
  resources :shifts, only: [:create, :index, :destroy]
end
