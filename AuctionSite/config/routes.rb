Rails.application.routes.draw do

get '/users/list', to: 'users#list'
get '/users/new', to: 'users#new'
post '/users', to: 'users#create'
get '/users/:id', to: 'users#show'
get '/products', to: 'products#index'
get '/products/new', to: 'products#new'
get '/products/:id', to: 'products#show'
post 'products', to: 'products#create'

end
