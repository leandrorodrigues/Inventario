class AddPlaniliaToItems < ActiveRecord::Migration
  def change
    add_column :items, :brand_name, :string
    add_column :items, :model_name, :string
    add_column :items, :serial_number, :string
    add_column :items, :warranty_date, :date
    add_column :items, :value, :decimal
    add_column :items, :net_value, :decimal
  end
end
