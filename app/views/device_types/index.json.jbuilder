json.array!(@device_types) do |device_type|
  json.extract! device_type, :id, :title
  json.url device_type_url(device_type, format: :json)
end
