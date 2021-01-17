Rails.application.routes.draw do
  namespace :api do
    resources :authors
    resources :books
  end
end
