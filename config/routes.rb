Rails.application.routes.draw do
  
root to:'home#index'

get 'home/index'

get 'styles/atoms'

get 'styles/molecules'

get 'styles/organisms'

resources :sessions, only: [:new, :create, :destroy]

resources :users do
  resources :goals
end 

resources :ideas do
  resources :comments
end 

get 'account', to: 'account#edit'
patch 'account', to: 'account#update'
  
get 'account/ideas'

get 'login', to: 'sessions#new'

get 'signup', to: 'users#new'

  # get 'complete/style/guide', to:'styles#atoms'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
