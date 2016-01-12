json.array!(@containers) do |container|
  json.extract! container, :id, :title, :place_id, :item_id, :container_id
  json.url container_url(container, format: :json)
end
