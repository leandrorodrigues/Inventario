class AddReverseToContainers < ActiveRecord::Migration
  def change
    add_column :containers, :reverse, :bool
  end
end
