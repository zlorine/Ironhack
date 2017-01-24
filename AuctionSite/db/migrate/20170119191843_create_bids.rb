class CreateBids < ActiveRecord::Migration[5.0]
  def change
    create_table :bids do |t|
    	t.integer :product_id
    	t.integer :user_id
      	t.integer :amount
     	t.timestamps
    end
  end
end
