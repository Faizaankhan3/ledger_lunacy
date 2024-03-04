Rails.application.routes.draw do
  root 'homepage#index'
  resources :ledgers, only: :show, constraints: { format: 'json' }
end
