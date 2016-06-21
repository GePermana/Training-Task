Rails.application.routes.draw do
  get 'comments/index'

  get 'comments/new'

  get 'comments/edit'

  get 'articles/index'

  get 'articles/new'

  get 'articles/edit'

  get 'comments/index'

    get 'comments/new'

    get 'comments/edit'

    root :to => "posts#index"

resources :comments
    resources :articles

 get "sign_up" => "users#new", :as => "sign_up"
 resources :users
 resources :sessions
  resources :posts
  #root 'posts#index'
  
end
