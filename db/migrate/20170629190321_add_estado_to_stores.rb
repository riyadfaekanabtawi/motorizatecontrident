class AddEstadoToStores < ActiveRecord::Migration
  def change
    add_column :stores, :estado, :string
    add_column :stores, :fase, :integer
  end
end
