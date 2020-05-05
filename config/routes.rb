Rails.application.routes.draw do
  get 'account/ideas'

root to:'home#index'

get 'home/index'


 get 'ideas/index'

 get 'ideas/new'

 post 'ideas/create'

  
  get 'styles/atoms'

  get 'styles/molecules'

  get 'styles/organisms'

  get '/ideas/:id/edit', to:'ideas#edit', as:'edit_idea'

  patch '/ideas/:id', to: 'ideas#update', as: 'idea'

  
  

  # get 'complete/style/guide', to:'styles#atoms'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
