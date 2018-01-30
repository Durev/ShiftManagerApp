Rails.application.routes.draw do
  get 'workers/index'
  resources :workers
end
