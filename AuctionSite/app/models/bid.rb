class Bid < ApplicationRecord
	belongs_to :product
	belongs_to :user

	validates :amount, presence: true
	validates_presence_of :user_id, message: 'Every bid needs a bidder!' 
	validate :bids_before_deadline 

	def bids_before_deadline
		debugger
		if DateTime.now > self.product.deadline
			errors.add(:date, "can't be after deadline")
	      	redirect(:back)
	    end
  	end

end


