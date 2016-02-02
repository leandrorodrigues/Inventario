class AddDeviceToContainerSlots < ActiveRecord::Migration
  def change
    add_reference :container_slots, :device, index: true, foreign_key: true
    execute "UPDATE container_slots AS cs SET device_id = (SELECT id FROM devices where item_id = cs.item_id)"

    remove_foreign_key :container_slots, :item
    remove_reference :container_slots, :item
  end
end
