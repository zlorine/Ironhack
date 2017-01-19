class ProductsController < ApplicationController

	def index
		@products = Product.all.order(deadline: :asc, title: :asc)
	end

	def new
		@new_product = Product.new
	end

	def show
		@product = Product.all.find_by(id: params[:id])
	end

	def create
		@new_product = Product.create!(title: params[:product][:title], description: params[:product][:description], deadline: params[:product][:deadline], user_id: params[:product][:user_id])
		redirect_to "/products"
	end

end
