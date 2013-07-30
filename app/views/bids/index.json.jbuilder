json.array!(@bids) do |bid|
  json.extract! bid, :bid_name, :bid_organ_id, :bid_amount, :bid_number, :bid_begin_date, :bid_finish_date, :city_id, :products_id, :bid_content, :bid_link
  json.url bid_url(bid, format: :json)
end
