class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :nombre
      t.string :ciudad
      t.string :direccion

      t.timestamps
    end
  end
end
