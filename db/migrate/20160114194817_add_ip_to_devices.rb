class AddIpToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :ip, :string
    add_column :devices, :host, :string
    add_column :devices, :description, :string
  end
end
