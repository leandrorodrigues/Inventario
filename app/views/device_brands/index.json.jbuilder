json.array!(@device_brands) do |device_brand|
  json.extract! device_brand, :id, :title
  json.url device_brand_url(device_brand, format: :json)
end
