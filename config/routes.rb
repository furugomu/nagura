Nagura::Application.routes.draw do
  root to: 'dojos#index', as: :dojos
  match 'page/:page' => 'dojos#index'
  resources :dojos
end
