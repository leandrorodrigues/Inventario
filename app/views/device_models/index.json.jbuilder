json.array!(@device_models) do |device_model|
  json.extract! device_model, :id, :title, :device_brand_id, :device_type_id, :rack_units, :ethernet_interfaces
  json.url device_model_url(device_model, format: :json)
end
