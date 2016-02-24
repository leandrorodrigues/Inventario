class ChangeColumnNullDevicesItemId < ActiveRecord::Migration
  def change
    change_column_null :devices, :item_id, true
  end
end
