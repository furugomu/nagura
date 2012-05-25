Nagura::Application.routes.draw do
  root to: 'dojos#index'
  match 'page/:page' => 'dojos#index'
  resources :dojos
end
