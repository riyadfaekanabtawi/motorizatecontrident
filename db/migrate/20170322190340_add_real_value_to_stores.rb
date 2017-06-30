class AddRealValueToStores < ActiveRecord::Migration
  def change
    add_column :stores, :real_value, :integer
  end
end
