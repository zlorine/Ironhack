class ContactsController < ApplicationController
	def index
		@contacts = Contact.order(:name)
	end

	def new
		@contact = Contact.new
	end

	def create
		@contact = Contact.new(
  		:name => params[:contact][:name],
  		:number => params[:contact][:number],
  		:email_address =>  params[:contact][:email_address],
  		:address => params[:contact][:address]
  		)
  	@contact.save

  	redirect_to "/"

	end

	def show
		params[:name] = params[:name].capitalize
		@contact = Contact.find_by(name: params[:name])
		render "no_contact" unless @contact

	end

	def favourites

		@contacts = Contact.where(favourite: true)

	end

	def fav
		contact = Contact.find_by(id: params[:id])
		contact.favourite = contact.favourite.!
		contact.save
		redirect_to(:back)
	end

end
