class AddEmailAddressToContacts < ActiveRecord::Migration[5.0]
  def change
  	add_column :contacts, :email_address, :string 
  end
end
