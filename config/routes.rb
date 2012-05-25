Nagura::Application.routes.draw do
  root to: 'dojos#index', as: :dojos
  resources :dojos
end
