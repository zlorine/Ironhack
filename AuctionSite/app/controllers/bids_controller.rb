class BidsController < ApplicationController

	def create
		
		product = Product.find_by(id: params[:bid][:product_id]) 
		user = User.find_by(email_address: params[:bid][:user_id])
		if product.user_id == user.id
			@error_message == "Can't bid oneself, smarty pants..."
			redirect_to (:back)
		else
			@new_bid = Bid.create!(amount: params[:bid][:amount].to_f, user_id: user.id, product_id: product.id)
			redirect_to (:back)
	    end

	end

end
