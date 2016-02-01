class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :items, :model_name, :model_description
  end
end
