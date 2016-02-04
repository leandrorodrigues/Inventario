json.array!(@interfaces) do |interface|
  json.extract! interface, :id, :title, :device_id, :address, :interface_type_id, :mac
  json.url interface_url(interface, format: :json)
end
