class AddUnknownToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :unknown, :bool, :null => false, :default => 0
  end
end
