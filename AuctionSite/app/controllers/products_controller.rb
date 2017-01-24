class ProductsController < ApplicationController


	def index
		@products = Product.all.order(deadline: :asc, title: :asc)
	end

	def new
		@user = User.find_by(id: params[:user_id])
		@new_product = @user.products.new
	end

	def show
		@new_bid = Bid.new
		@product = Product.find_by(id: params[:id])
		@bids = @product.bids
	end

	def create
		@user = User.find_by(id: params[:user_id])
		@new_product = @user.products.create!(
			title: params[:product][:title], 
			description: params[:product][:description], 
			deadline: params[:product][:deadline]
			)
		redirect_to "/products"
	end

	def destroy
		Product.find_by(id: params[:id]).destroy
		redirect_to "/products"
	end

end


