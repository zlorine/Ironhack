class UsersController < ApplicationController

	def index
		@users = User.all.order(name: :asc)
		@products = Product.all.order(deadline: :asc, title: :asc)
	end

	def new
		@new_user = User.new
	end

	def create
		@new_user = User.create!(name: params[:user][:name], email_address: params[:user][:email_address])
		redirect_to "/users"
	end

	def show
		@user = User.all.find_by(id: params[:id])
		@products = []
		@products << Product.find_by(user_id: params[:id])
	end

end

