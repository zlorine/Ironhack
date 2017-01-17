Rails.application.routes.draw do

  get '/', to: 'contacts#index'
  get '/new', to: 'contacts#new'
  post '/new', to: 'contacts#create'
  get '/favourites', to: 'contacts#favourites'
  patch '/fav/:id', to: 'contacts#fav', as: :fav
  get '/:name', to: 'contacts#show'



end
