class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
  	    t.integer :user_id
	    t.text :title
	    t.text :description
	    t.datetime :deadline
	    t.timestamps
    end
  end
end
