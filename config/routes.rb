# aboutと書くだけで、twitterへようこそのページを出せるようにしたい
Twitter::Application.routes.draw do
  root  'about#index'
  match '/about', to:'about#index', via:'get'
  resources :users
  resources :tweets
end