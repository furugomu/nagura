Nagura::Application.routes.draw do
  root to: 'dojos#index'
  match 'page/:page' => 'dojos#index'
  resources :dojos do
    collection do
      get :next, to: :next_dojo # next は 予約語なので回避
    end
  end
  get 'next' => 'dojos#next_dojo'
end
