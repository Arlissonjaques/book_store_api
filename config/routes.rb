Rails.application.routes.draw do
  namespace :api do
    resources :authors
    resources :books
    resources :clients
    resources :form_of_payments
  end
end
