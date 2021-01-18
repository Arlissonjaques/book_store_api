Rails.application.routes.draw do
  namespace :api do
    resources :authors
    resources :books
    resources :clients
  end
end
