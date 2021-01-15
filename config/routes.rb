Rails.application.routes.draw do
  namespace :api do
    resources :authors
  end
end
