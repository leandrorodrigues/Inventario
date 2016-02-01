class AddFiberInterfacesToDeviceModels < ActiveRecord::Migration
  def change
    add_column :device_models, :fiber_interfaces, :int
  end
end
