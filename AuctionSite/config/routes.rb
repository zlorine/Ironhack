Rails.application.routes.draw do

get '/products', to: 'products#index'

resources :users do
	resources :products
end

post '/bids', to: 'bids#create'


end

