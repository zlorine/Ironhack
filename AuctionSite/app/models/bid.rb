class Bid < ApplicationRecord
	belongs_to :product
	belongs_to :user

	validates :amount, presence: true
	validates_presence_of :user_id, message: 'Every bid needs a bidder!' 
	validate :bids_after_deadline, :no_bids_to_oneself 

	def bids_after_deadline
		if DateTime.now > self.product.deadline
			errors.add(:message, "can't be after deadline")
	    end
  	end

  	def no_bids_to_oneself 
		if  self.product.user_id == self.user.id
			errors.add(:message, "can't bid for oneself")
	    end
  	end
end


