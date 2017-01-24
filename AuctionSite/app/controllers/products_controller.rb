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
		@deadline = @product.deadline.to_datetime
		@bids = @product.bids.order(amount: :desc)
		
		if  @deadline  > DateTime.now && @bids.size != 0
			@winner = @bids[0]
		elsif @bids.size == 0
			@winner = nil
		end

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


#add entry_params
