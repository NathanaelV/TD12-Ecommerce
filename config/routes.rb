Rails.application.routes.draw do
  root 'warehouses#index'
  resources :warehouses, only: %i[show]
end
