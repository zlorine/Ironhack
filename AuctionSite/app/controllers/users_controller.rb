class UsersController < ApplicationController

	def list
		@users = User.all.order(name: :asc)
	end

end

