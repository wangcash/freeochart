json.array!(@comps) do |comp|
  json.extract! comp, :comp_id, :comp_name, :area_code, :tel, :www, :brief
  json.url comp_url(comp, format: :json)
end
