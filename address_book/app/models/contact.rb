class Contact < ApplicationRecord
	validates :name, presence: true
	validates :name, format: { with: /[a-z]/, message: 'people are not numbers'} 
end
