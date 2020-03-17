Rails.application.routes.draw do
  resources :receipts
  resources :suppliers
  resources :appointments
  resources :clients
  resources :employees
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "#{ENV['TIENDA_TOKEN']}", to: "webhook#index"
end
