class Bid < ApplicationRecord
	belongs_to :product
	belongs_to :user

	validates :amount, presence: true
	validates_presence_of :user_id, message: 'Every bid needs a bidder!' 

end


