class AddAllocationToItem < ActiveRecord::Migration
  def change
    add_column :items, :allocation, :text
  end
end
