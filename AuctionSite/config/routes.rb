Rails.application.routes.draw do

get '/users/list', to: 'users#list'
get '/users/new', to: 'users#new'
post '/users', to: 'users#create'
get '/users/:id', to: 'users#show'

end
