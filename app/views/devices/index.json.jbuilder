json.array!(@devices) do |device|
  json.extract! device, :id, :title, :item_id_id, :device_model_id_id, :container_slots_id
  json.url device_url(device, format: :json)
end
