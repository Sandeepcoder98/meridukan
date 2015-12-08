json.array!(@admin_sub_categories) do |admin_sub_category|
  json.extract! admin_sub_category, :id
  json.url admin_sub_category_url(admin_sub_category, format: :json)
end
