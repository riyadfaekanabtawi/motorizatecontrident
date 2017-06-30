class AddRazonSocialAndClientToStores < ActiveRecord::Migration
  def change
    add_column :stores, :razon_social, :string
    add_column :stores, :cliente, :string
  end
end
