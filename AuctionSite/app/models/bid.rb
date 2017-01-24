class Bid < ApplicationRecord
	belongs_to :product
	belongs_to :user

	validates :amount, presence: true
	validates_presence_of :user_id, message: 'Every bid needs a bidder!' 
	validates :user_id, uniqueness: {case_sensitive: false, message: 'this email has been used already'}

end


