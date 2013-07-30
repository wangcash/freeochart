class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.string :bid_name
      t.string :bid_organ_id
      t.string :bid_amount
      t.string :bid_number
      t.date :bid_begin_date
      t.date :bid_finish_date
      t.string :city_id
      t.string :products_id
      t.text :bid_content
      t.string :bid_link

      t.timestamps
    end
  end
end
