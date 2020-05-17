Rails.application.routes.draw do
  get 'home/index'
  put 'home/update_profile'
  get 'home/edit_password'
  put 'home/update_password'
  get 'session/show_login'
  post 'session/login'
  get 'session/logout'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  put 'user_password/:id', to: 'users#reset_password', as: :reset_password
  
  resources :users, :articles
  resources :tags, except: :show
  
  
  get 'blog/:id', to: 'blog#show' ,as: :blog_show
  get 'blogs/:user_id', to: 'blog#index', as: :blog_index
  get 'author/:id', to: 'blog#author', as: :author_show
end
