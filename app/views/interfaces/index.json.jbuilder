json.array!(@interfaces) do |interface|
  json.extract! interface, :id, :title, :device_id, :address, :interface_type_id, :mac
  json.url device_interface_url(interface.device, interface, format: :json)
end
