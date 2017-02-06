class BidsController < ApplicationController

	def create
		
		product = Product.find_by(id: params[:bid][:product_id]) 
		user = User.find_by(email_address: params[:bid][:user_id])
		@new_bid = Bid.new(amount: params[:bid][:amount].to_f, user_id: user.id, product_id: product.id)
		if  @new_bid.valid?
			flash[:alert] = "bid accepted!" 
			@new_bid.save!
		elsif @new_bid.valid? == false
			flash[:alert] = @new_bid.errors[:message].reduce{|mess| mess.to_s}
	    end
	    redirect_to (:back)
	end

end


#add entry_params