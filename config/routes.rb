Rails.application.routes.draw do
  root 'matches#index'

  resources :fighters
  resources :matches do
    member do
      post 'start'
      post 'stop'
      post 'reset'
      post 'add_point'
      post 'add_penalty'
    end
  end
end