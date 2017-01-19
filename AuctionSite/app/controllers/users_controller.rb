class UsersController < ApplicationController

	def list
		@users = User.all.order(name: :asc)
	end

	def new
		@new_user = User.new
	end

	def create
		@new_user = User.create!(name: params[:user][:name], email_address: params[:user][:email_address])
		redirect_to "/users/list"
	end

	def show
		@user = User.all.find_by(id: params[:id])
	end

end

