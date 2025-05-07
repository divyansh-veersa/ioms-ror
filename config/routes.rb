Rails.application.routes.draw do
  devise_for :admins

  root "dashboard#index"

  resources :products
  resources :customers

  resources :orders do
    member do
      patch :process_order
      patch :ship_order
      patch :deliver_order
      patch :cancel_order
    end
  end
end
