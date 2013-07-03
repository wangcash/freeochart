json.array!(@ocharts) do |ochart|
  json.extract! ochart, :ochart_id, :department_name, :parent_id, :comp_id
  json.url ochart_url(ochart, format: :json)
end
